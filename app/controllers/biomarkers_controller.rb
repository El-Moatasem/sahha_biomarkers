class BiomarkersController < ApplicationController
  before_action :set_sahha_service

  # Fetches heart-rate biomarkers
  def heart_rate
    fetch_biomarkers('heart-rate')
  end

  # Fetches calories biomarkers
  def calories
    fetch_biomarkers('calories')
  end

  # Fetches sleep biomarkers
  def sleep
    fetch_biomarkers('sleep')
  end

  # Fetches biomarkers based on the biomarker type
  def fetch_biomarkers(biomarker_type)
    client_id = ENV['SAHHA_SANDBOX_CLIENT_ID'] # Fetch client ID from ENV
    external_id = params[:externalId] # Pass this in the request
    start_date_time = params[:startDateTime]
    end_date_time = params[:endDateTime]

    # Retrieve biomarkers based on client_id, external_id, and biomarker_type
    result = Biomarker.where(
      client_id: client_id,
      external_id: external_id,
      biomarker_type: biomarker_type
    ).where(recorded_at: start_date_time..end_date_time)

    render json: result
  end

  def create
    biomarker = Biomarker.new(biomarker_params)
    external_id = params[:externalId] # Ensure externalId is passed in request
    client_id = ENV['SAHHA_SANDBOX_CLIENT_ID'] # Fetch client ID from ENV

    biomarker.client_id = client_id
    biomarker.external_id = external_id

    if biomarker.save
      log_entry = {
        id: SecureRandom.uuid,
        parentId: nil,
        logType: biomarker.category,  # Use biomarker category
        dataType: biomarker.biomarker_type,
        value: biomarker.value["average"],
        unit: biomarker.value["unit"],
        source: "WebAPIs",
        recordingMethod: "RECORDING_METHOD_UNKNOWN",
        deviceType: external_id,
        startDateTime: biomarker.recorded_at.iso8601,
        endDateTime: biomarker.recorded_at.iso8601,
        additionalProperties: {},
        category: biomarker.category,
        periodicity: "daily",
        aggregation: "sum"
      }

      @sahha_service.log_profile_data([log_entry], external_id)

      render json: { status: 'Biomarker created successfully', data: biomarker }, status: :created
    else
      render json: { error: 'Failed to create biomarker', details: biomarker.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Retrieve biomarkers based on client_id, external_id, category, and biomarker_type
  def retrieve_biomarkers
    client_id = ENV['SAHHA_SANDBOX_CLIENT_ID'] # Fetch client ID from ENV
    external_id = params[:externalId]
    categories = params[:categories] # Expecting a list of categories
    biomarker_types = params[:biomarker_types] # Expecting a list of biomarker types
    start_date_time = params[:startDateTime]
    end_date_time = params[:endDateTime]

    # Initialize the query with client_id and external_id (both are mandatory)
    query = Biomarker.where(client_id: client_id, external_id: external_id)

    # Check if categories is an array and apply the filter using the IN query
    query = query.where(category: categories) if categories.present? && categories.is_a?(Array)

    # Check if biomarker_types is an array and apply the filter using the IN query
    query = query.where(biomarker_type: biomarker_types) if biomarker_types.present? && biomarker_types.is_a?(Array)

    # Apply date range filter if both start and end times are provided
    query = query.where(recorded_at: start_date_time..end_date_time) if start_date_time.present? && end_date_time.present?

    # Execute the query and return the result
    result = query

    render json: result
  end


  private

  def set_sahha_service
    @sahha_service = SahhaService.new
  end

  def biomarker_params
    params.require(:biomarker).permit(:biomarker_type, :recorded_at, :category, value: {})
  end
end
