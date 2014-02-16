class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  include HandlesErrors
  respond_to :json
end
