Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "/products", controller: "products", action: "index"

  get "/products/:id", controller: "products", action: "show"

  post "/products", controller: "products", action: "create"

  patch "/products/:id", controller: "products", action: "update"

  delete "/products/:id", controller: "products", action: "destroy"

  post "/users", controller: "users", action: "create"

  post "/sessions" => "sessions#create"
end
