class BiomarkersController < ApplicationController
  before_action :set_sahha_service

  def heart_rate
    render json: @sahha_service.fetch_biomarker('heart-rate')
  end

  def calories
    render json: @sahha_service.fetch_biomarker('calories')
  end

  def sleep
    render json: @sahha_service.fetch_biomarker('sleep')
  end


  def create
    biomarker = Biomarker.new(biomarker_params)

    puts("create_log_entry", params[:externalId])
    if biomarker.save
      log_entry = {
        id: params[:externalId],
        parentId: params[:externalId],
        logType: biomarker.biomarker_type, # Fix: Changed from `biotype` to `biomarker_type`
        dataType: biomarker.value["unit"],
        value: biomarker.value["average"],
        unit: biomarker.value["unit"],
        source: "iPhone X",
        recordingMethod: "RECORDING_METHOD_UNKNOWN",
        deviceType: "iPhone13,2",
        startDateTime: biomarker.recorded_at.iso8601,
        endDateTime: biomarker.recorded_at.iso8601,
        additionalProperties: ""
      }

      @sahha_service.log_profile_data([log_entry])

      render json: { status: 'Biomarker created successfully', data: biomarker }, status: :created
    else
      render json: { error: 'Failed to create biomarker', details: biomarker.errors.full_messages }, status: :unprocessable_entity
    end
  end


  def register_profile
    external_id = params[:externalId]
    result = @sahha_service.register_profile(external_id)
    render json: result
  end

  def get_profile_biomarkers
    external_id = params[:externalId]
    categories = params[:categories]
    types = params[:types]
    start_date_time = params[:startDateTime]
    end_date_time = params[:endDateTime]
    
    result = @sahha_service.get_profile_biomarkers(categories, types, start_date_time, end_date_time, external_id)
    render json: result
  end

  private

  def set_sahha_service
    @sahha_service = SahhaService.new
  end

  def biomarker_params
    params.require(:biomarker).permit(:biomarker_type, :recorded_at, value: {})
  end
end
