class StoreController < ApplicationController
	skip_before_action :authorize
	before_action :set_cart, :log_on_this_page, only: :index
	include CurrentCart
	def index
		if params[:set_locale]
		    redirect_to store_url(locale: params[:set_locale])
		else
			@products = Product.order(:title)
			@number_of_logs = session[:counter] 
		end
	end
# se apeleaza din concern :set_cart si afiseaza mereu un nou 
# obiect @cart 

	private
	def log_on_this_page
		if session[:counter].nil?
			session[:counter] = 1
		else 
			session[:counter] = session[:counter] + 1
		end
	end

end
