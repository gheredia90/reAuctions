Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions" }
  get 'profile', to: 'users#show'   
  resources :users
  resources :rfps, only: [:new, :create, :show, :edit, :destroy]
  root to: 'users#home'
  get '/dashboard' => 'users#home'
 
end


#                   Prefix Verb   URI Pattern                    Controller#Action
#         new_user_session GET    /users/sign_in(.:format)       users/sessions#new
#             user_session POST   /users/sign_in(.:format)       users/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)      users/sessions#destroy
#            user_password POST   /users/password(.:format)      devise/passwords#create
#        new_user_password GET    /users/password/new(.:format)  devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format) devise/passwords#edit
#                          PATCH  /users/password(.:format)      devise/passwords#update
#                          PUT    /users/password(.:format)      devise/passwords#update
# cancel_user_registration GET    /users/cancel(.:format)        users/registrations#cancel
#        user_registration POST   /users(.:format)               users/registrations#create
#    new_user_registration GET    /users/sign_up(.:format)       users/registrations#new
#   edit_user_registration GET    /users/edit(.:format)          users/registrations#edit
#                          PATCH  /users(.:format)               users/registrations#update
#                          PUT    /users(.:format)               users/registrations#update
#                          DELETE /users(.:format)               users/registrations#destroy
#                  profile GET    /profile(.:format)             users#profile
#                    users GET    /users(.:format)               users#index
#                          POST   /users(.:format)               users#create
#                 new_user GET    /users/new(.:format)           users#new
#                edit_user GET    /users/:id/edit(.:format)      users#edit
#                     user GET    /users/:id(.:format)           users#show
#                          PATCH  /users/:id(.:format)           users#update
#                          PUT    /users/:id(.:format)           users#update
#                          DELETE /users/:id(.:format)           users#destroy
#                     rfps POST   /rfps(.:format)                rfps#create
#                  new_rfp GET    /rfps/new(.:format)            rfps#new
#                 edit_rfp GET    /rfps/:id/edit(.:format)       rfps#edit
#                      rfp GET    /rfps/:id(.:format)            rfps#show
#                          DELETE /rfps/:id(.:format)            rfps#destroy
#                     root GET    /                              users#home
#          buyer_dashboard GET    /buyer_dashboard(.:format)     buyers#home
#       supplier_dashboard GET    /supplier_dashboard(.:format)  suppliers#home


