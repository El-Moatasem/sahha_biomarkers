Rails.application.routes.draw do
  get 'biomarkers/heart_rate', to: 'biomarkers#heart_rate'
  get 'biomarkers/calories', to: 'biomarkers#calories'
  get 'biomarkers/sleep', to: 'biomarkers#sleep'

  # POST route for creating biomarker data
  post 'biomarkers', to: 'biomarkers#create'
end
