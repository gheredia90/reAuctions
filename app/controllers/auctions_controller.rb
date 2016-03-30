class AuctionsController < ApplicationController

	def new	
		@auction = Auction.new		
		@suppliers = params[:suppliers]
		puts @suppliers
		#params[:suppliers].each_value {|value| @auction.suppliers << User.find_by_id(value)}		
	end	

	def create
		@auction = Auction.new auction_params
		@auction.buyer = current_user
		@auction.opened = true
		params[:suppliers].each_value {|value| @auction.suppliers << User.find_by_id(value)}
		if @auction.save
			flash[:notice] = "Auction successfully created"
			redirect_to dashboard_path			
		else
			render 'new'
		end
	end	

	def show
		@auction = Auction.find_by_id(params[:id])
		
		if current_user.role == 'Buyer'
	      render 'auction_buyer_display'
	    else
	      render 'auction_supplier_display'
	    end
	end

	

	private
	def auction_params
		params.require(:auction).permit(:title, :description, :lowest_bid)
	end

end