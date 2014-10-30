class StoreController < ApplicationController
	before_action :log_on_this_page, only: :index
	def index
		@products = Product.order(:title)
		@number_of_logs = session[:counter] 
	end


	private
	def log_on_this_page
		if session[:counter].nil?
			session[:counter] = 1
		else 
			session[:counter] = session[:counter] + 1
		end
	end

end
