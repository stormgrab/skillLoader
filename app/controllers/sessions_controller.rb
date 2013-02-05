class SessionsController < ApplicationController
  def new
		@user=User.new
  end

  def create
		respond_to do |format|		
			if user = User.authenticate(params[:email],params[:password])
				session[:user_id] = user.id
				format.html { redirect_to user, notice: 'Logged in successfully' }
				format.json { render json: user, status: :created, location: user }
		  else
		    format.html { redirect_to '/landing'}
				format.json { render json: user.errors, status: :unprocessable_entity }
		  end
		end
  end

	def destroy
		session[:user_id] = nil
		redirect_to landing_url, :notice => "Logged out"
	end
end
