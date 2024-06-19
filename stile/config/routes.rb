Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # NOTE: Not very RESTFUL but i'll keep it consistent for simplicity
  post 'import', to: 'student_test_results#import'

  get 'reports/:test_id/aggregate', to: 'reports#aggregate'
end
