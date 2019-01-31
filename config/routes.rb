Rails.application.routes.draw do
  get 'parser/index'
  root 'parser#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
