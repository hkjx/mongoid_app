class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |e|
 	redirect_to root_url, :alert => e.message
  end
end
