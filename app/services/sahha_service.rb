# app/services/sahha_service.rb
class SahhaService
  include HTTParty
  base_uri 'https://sandbox-api.sahha.ai/api/v1'

  def initialize
    @client_id = ENV['SAHHA_SANDBOX_CLIENT_ID']
    @client_secret = ENV['SAHHA_SANDBOX_CLIENT_SECRET']
    @headers = { 'Content-Type' => 'application/json' }
    @token = authenticate
  end

  def authenticate
    response = self.class.post('/oauth/account/token', body: {
      clientId: @client_id,
      clientSecret: @client_secret
    }.to_json, headers: @headers)

    if response.success?
      response.parsed_response['accountToken']
    else
      raise "Failed to authenticate: #{response.body}"
    end
  end

  def register_profile(external_id)
    response = self.class.post('/oauth/profile/register', body: {
      externalId: external_id
    }.to_json, headers: auth_headers)
    
    handle_response(response)
  end

  def fetch_biomarker(type)
    response = self.class.get("/biomarkers/#{type}", headers: auth_headers)
    handle_response(response)
  end

  private

  def auth_headers
    @headers.merge('Authorization' => "Bearer #{@token}")
  end

  def handle_response(response)
    if response.success?
      response.parsed_response
    else
      { error: response.parsed_response || response.body }
    end
  end
end
