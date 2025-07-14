# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

run Rails.application
Rails.application.load_server

# Remove these lines from config.ru - they don't belong here!
# Rails.application.routes.draw do
#   resources :students
#   root 'students#index'
# end
