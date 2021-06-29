Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #products routes
  get "/products", controller: "products", action: "index"

  get "/products/:id", controller: "products", action: "show"

  post "/products", controller: "products", action: "create"

  patch "/products/:id", controller: "products", action: "update"

  delete "/products/:id", controller: "products", action: "destroy"

  #users routes
  post "/users", controller: "users", action: "create"

  #sessions routes
  post "/sessions" => "sessions#create"

  #orders routes
  post "/orders" => "orders#create"
  get "/orders/:id" => "orders#show"
  get "/orders" => "orders#index"
end
