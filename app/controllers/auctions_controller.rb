class AuctionsController < ApplicationController


	def new	
		@auction = Auction.new		
		@suppliers = params[:suppliers]	
    @rfp_id = params[:rfp_id]
	end	

	def create
		auction = Auction.new auction_params
		auction.set_data(current_user) 
		params[:suppliers].each_value {|value| auction.suppliers << User.find_by_id(value)}
		if auction.save
      rfp = Rfp.find_by_id(params[:rfp_id])
      rfp.opened = false
      rfp.save
			redirect_to auction_path(auction)			
		else
			render 'new'
		end
	end	

	def show
		@auction = Auction.find_by_id(params[:id])
    
    gon.push({
      :start_date => @auction.get_start_date_ms,
      :end_date => @auction.get_end_date_ms,
      :role => current_user.role
    })
		respond_to do |format|
			format.html do
				if current_user.role == 'Buyer'
      		render 'auction_buyer_display'
		    else
		     	render 'auction_supplier_display'
		    end
			end
			format.json do
        render :json => {
          :bids => @auction.get_bids,
          :lowest_bid => @auction.lowest_bid,
          :supplier => @auction.get_lowest_bid_supplier.name,
          :names => @auction.get_bidders,
          :opened => @auction.opened,
          :dataset => @auction.get_bids_and_names
        }
			end
		end		
	end

	def send_bid
		auction = Auction.find_by_id(params[:id])
		bid = Bid.new
    bid.set_data(params[:bid], auction.id, current_user.id)		
    auction.set_lowest_bid 
    auction.save
		redirect_to auction_path		
	end

  def close_auction
    auction = Auction.find_by_id(params[:id])
    auction.opened = false
    auction.save
    redirect_to dashboard_path
  end  

  private
	def auction_params
		params.require(:auction).permit(:title, :description, :duration)
	end

end