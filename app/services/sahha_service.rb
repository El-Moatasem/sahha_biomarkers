class SahhaService
  include HTTParty
  base_uri 'https://sandbox-api.sahha.ai/api/v1'

  def initialize
    @client_id = ENV['SAHHA_SANDBOX_CLIENT_ID']
    @client_secret = ENV['SAHHA_SANDBOX_CLIENT_SECRET']
    @headers = { 'Content-Type' => 'application/json' }
    @token = authenticate
    @profile_token = nil
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

    if response.success?
      @profile_token = response.parsed_response['profileToken']
      ENV['PROFILE_TOKEN'] = @profile_token # Save token in ENV variable for future use
      response.parsed_response
    else
      raise "Failed to register profile: #{response.body}"
    end
  end

  # New method to get profile token using externalId
  def get_profile_token(external_id)
    response = self.class.post('/oauth/profile/token', body: {
      externalId: external_id
    }.to_json, headers: auth_headers)

    if response.success?
      @profile_token = response.parsed_response['profileToken']
      puts("@profile_token", @profile_token)
      ENV['PROFILE_TOKEN'] = @profile_token # Save token in ENV variable for future use
    else
      raise "Failed to get profile token: #{response.body}"
    end
  end

  def fetch_biomarker(type)
    response = self.class.get("/biomarkers/#{type}", headers: auth_headers)
    handle_response(response)
  end

  # Method to get profile biomarkers
  def get_profile_biomarkers(categories, types, start_date_time, end_date_time, external_id)
    # Ensure profile token is updated by calling get_profile_token
    get_profile_token(external_id)

    query = {
      categories: categories,
      types: types,
      startDateTime: start_date_time,
      endDateTime: end_date_time
    }
    response = self.class.get('/profile/biomarker', query: query, headers: profile_auth_headers)
    handle_response(response)
  end

  # New method to log profile data
  def log_profile_data(log_entries)
    response = self.class.post('/profile/data/log', body: log_entries.to_json, headers: profile_auth_headers)
    handle_response(response)
  end

  private

  def auth_headers
    @headers.merge('Authorization' => "Bearer #{@token}")
  end

  def profile_auth_headers
    { "Authorization" => "profile #{@profile_token}", "Content-Type" => "application/json" }
  end

  def handle_response(response)
    if response.success?
      response.parsed_response
    else
      { error: response.parsed_response || response.body }
    end
  end
end
