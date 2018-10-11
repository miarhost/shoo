  Rails.application.routes.draw do

  resource :shoo

  resolve("Shoo") { [:shoo] }
  
  end