class RfpsController < ApplicationController

	def show
		if current_user.role == 'Buyer'
	      render 'rfp_buyer_display'
	    else
	      render 'rfp_supplier_display'
	    end
	end	

	def new
		@rfp = Rfp.new		
	end

	def create
		@rfp = Rfp.new rfp_params
		@rfp.buyer = current_user
		if @rfp.save
			flash[:notice] = "RFP successfully created"
			redirect_to dashboard_path			
		else
			render 'new'
		end
	end

	def edit
	end

    def rfp_params
		params.require(:rfp).permit(:title, :description, :category)
	end
end