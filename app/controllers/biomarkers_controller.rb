class BiomarkersController < ApplicationController
  before_action :set_sahha_headers, only: [:heart_rate, :calories, :sleep]

  # Fetch biomarker data from Sahha API
  def heart_rate
    render json: fetch_biomarker('heart-rate')
  end

  def calories
    render json: fetch_biomarker('calories')
  end

  def sleep
    render json: fetch_biomarker('sleep')
  end

  # Create a biomarker record in the local database
  def create
    biomarker = Biomarker.new(biomarker_params)

    if biomarker.save
      render json: { status: 'Biomarker created successfully', data: biomarker }, status: :created
    else
      render json: { error: 'Failed to create biomarker', details: biomarker.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  # Set up Sahha headers with the authenticated token
  def set_sahha_headers
    @token = authenticate
    @headers = {
      "Authorization" => "Bearer #{@token}",
      "Content-Type" => "application/json"
    }
  end

  # Fetch a biomarker from the Sahha API
  def fetch_biomarker(type)
    response = HTTParty.get("https://sandbox-api.sahha.ai/v1/biomarkers/#{type}", headers: @headers)
    if response.success?
      response.parsed_response
    else
      render json: { error: "Failed to fetch #{type} biomarker data", details: response.parsed_response }, status: :bad_request
    end
  end

  # Authenticate with the Sahha API using Client Id and Secret
  def authenticate
    response = HTTParty.post(
      "https://sandbox-api.sahha.ai/auth/token",
      body: {
        client_id: ENV['SAHHA_CLIENT_ID'],
        client_secret: ENV['SAHHA_CLIENT_SECRET'],
        grant_type: 'client_credentials'
      }.to_json,
      headers: { 'Content-Type' => 'application/json' }
    )

    if response.success?
      response.parsed_response['access_token']
    else
      raise "Failed to authenticate with Sahha API: #{response.parsed_response['error']}"
    end
  end

  # Strong parameters for biomarker creation
  def biomarker_params
    params.require(:biomarker).permit(:biomarker_type, :recorded_at, value: {})
  end
end
