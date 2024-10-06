# app/controllers/biomarkers_controller.rb

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

    if biomarker.save
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


  private

  def set_sahha_service
    @sahha_service = SahhaService.new
  end

  def biomarker_params
    params.require(:biomarker).permit(:biomarker_type, :recorded_at, value: {})
  end



end
