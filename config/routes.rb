Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :rides, only: [ :create ]
      patch "start", to: "rides#bill_and_update_status_to_started"
      patch "complete", to: "rides#pay_and_update_status_to_completed"
      patch "cancel", to: "rides#reimburse_and_update_status_to_cancelled"
    end
  end

end
