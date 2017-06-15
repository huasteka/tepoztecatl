Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope :api do
    resources :storages
    resources :measure_units
    resources :items
    scope :operations do
      post 'deposit', to: 'operations#deposit', via: :post
      post 'withdraw', to: 'operations#withdraw', via: :post
      post 'transfer', to: 'operations#transfer', via: :post
    end
  end

  match '*path' => redirect('/'), via: :all
end
