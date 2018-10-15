 Rails.application.routes.draw do

  resource :shoo, only: [:create, :edit, :update]

  resolve('Shoo') { [:shoo] }
  
 end	