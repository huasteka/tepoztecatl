Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope :api do
    scope :v1 do
      resources :storages
      resources :measure_units
      resources :items
    end
  end
  match '*path' => redirect('/'), via: :all
end
