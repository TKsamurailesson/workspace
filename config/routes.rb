Rails.application.routes.draw do
  get "login" => "users#login_form"
  post "login" => "users#login"


  get "users/index" => "users#index"
  get "users/list" => "users#list"
  get "users/signup" => "users#new"
  get "users/:id" => "users#show"
  post "users/create" => "users#create"
  get "users/:id/edit" => "users#edit"
  # updateアクションへのルーティングを追加してください
  post "users/:id/update" => "users#update"
  post "users/:id/destroy" => "users#destroy"


  get "posts/index" => "posts#index"
  get "posts/new" => "posts#new"
  get "posts/:id" => "posts#show"
  post "posts/create" => "posts#create"
  get "posts/:id/edit" => "posts#edit"
  # updateアクションへのルーティングを追加してください
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"


  get "/" => "home#top"
  get "about" => "home#about"
end
