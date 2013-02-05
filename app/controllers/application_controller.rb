class ApplicationController < ActionController::Base
  protect_from_forgery

	private
	def current_user
		User.find(session[:user_id])
	rescue ActiveRecord::RecordNotFound
		redirect_to landing_url,"Login or register to continue"
	end
end
