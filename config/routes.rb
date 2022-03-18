Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/', to: redirect('/index.html')

  scope :api do
    resources :storages
    post 'storages/:parent_id/add', to: 'storages#create_child'
    resources :measure_units
    resources :items
    scope :operations do
      match 'stocks/history', to: 'operations#history', via: :get
      match 'stocks/deposit', to: 'operations#deposit', via: :post
      match 'stocks/withdraw', to: 'operations#withdraw', via: :post
      match 'stocks/transfer', to: 'operations#transfer', via: :post
      match 'stocks/:stock_id/set_minimum', to: 'operations#set_minimum_stock', via: :post
    end
  end

  match '*path', :to => 'application#routing_error', via: :all
end
