Rails.application.routes.draw do
  resources :employees do
    collection do 
      post :import
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
