class SessionsController < ApplicationController
	skip_before_action :authorize

	def new
	end

	def create
		user = User.find_by(name: params[:name])
		if user and user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to admin_url
		else
	       flash.now
	       flash[:alert] = "Invalid user/password combination"
	       redirect_to action: :new
		end
	end

	def destroy
		session[:user_id] = nil
        redirect_to store_url, notice: "Logged out"
	end
end
