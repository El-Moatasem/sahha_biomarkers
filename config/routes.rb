Rails.application.routes.draw do

  # Route for retrieving biomarkers based on client_id, external_id, and categories
  get 'biomarkers/retrieve', to: 'biomarkers#retrieve_biomarkers'

  # Route for heart_rate, calories, and sleep actions
  get 'biomarkers/heart_rate', to: 'biomarkers#heart_rate'
  get 'biomarkers/calories', to: 'biomarkers#calories'
  get 'biomarkers/sleep', to: 'biomarkers#sleep'

  # Route for creating new biomarkers
  post 'biomarkers', to: 'biomarkers#create'

  # Route for registering a profile
  post 'biomarkers/register_profile', to: 'biomarkers#register_profile'
end



