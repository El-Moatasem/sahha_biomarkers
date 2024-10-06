

require 'securerandom'

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
  external_id = params[:externalId] # Ensure externalId is passed in request

  if biomarker.save
    log_entry = {
      id: SecureRandom.uuid,  
      parentId: nil,
      logType: biomarker.category, # use biomarker type
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

    @sahha_service.log_profile_data([log_entry], external_id) # Pass external_id to log_profile_data

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
    params.require(:biomarker).permit(:biomarker_type, :recorded_at, :category, value: {})
  end

end
