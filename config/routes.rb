Rails.application.routes.draw do
  # GET routes for fetching biomarker data
  get 'biomarkers/heart_rate', to: 'biomarkers#heart_rate'
  get 'biomarkers/calories', to: 'biomarkers#calories'
  get 'biomarkers/sleep', to: 'biomarkers#sleep'

  # POST route for creating biomarker data
  post 'biomarkers', to: 'biomarkers#create'

  # POST route for registering profile
  post 'biomarkers/register_profile', to: 'biomarkers#register_profile'
   # GET route for fetching profile biomarkers
  get 'biomarkers/profile_biomarkers', to: 'biomarkers#get_profile_biomarkers'
end


