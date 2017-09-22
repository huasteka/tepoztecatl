Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'index#index'

  scope :api do
    resources :storages
    post 'storages/:parent_id/add', to: 'storages#create_child'
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
