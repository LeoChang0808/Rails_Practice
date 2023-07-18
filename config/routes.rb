Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "articles#index"
  
  get '/articles', to: 'articles#index'

  get '/articles/new', to: 'articles#new'

  get '/articles/:id', to: 'articles#show', as: 'article'

  get '/articles/:id/edit', to: 'articles#edit', as: 'edit_article'
  
  post '/articles', to: 'articles#create'

  patch '/articles/:id', to: 'articles#update'

  delete '/articles/:id', to: 'articles#destroy'

  resource :users, except:[:destroy, :show]

  get '/about', to: 'pages#about'
end
