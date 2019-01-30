Rails.application.routes.draw do
  get 'parser/rubysec'
  root 'parser#rubysec'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
