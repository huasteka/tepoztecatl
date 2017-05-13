Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope :v1 do
    resources :storages
    resources :measure_units
  end
  match '*path' => redirect('/'), via: :all
end
