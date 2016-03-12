class RfpsController < ApplicationController

	def show
		@rfp = Rfp.find_by(params[:id])
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
		@rfp = Rfp.find params[:id]
	end

	def update
		@rfp = Rfp.find params[:id]
		if @rfp.update_attributes rfp_params
			flash[:notice] = "Entry updated successfully"
			redirect_to dashboard_path
		else
			flash.now[:errors] = @rfp.errors.full_messages
			render 'edit'
		end
	end

    def rfp_params
		params.require(:rfp).permit(:title, :description, :category)
	end
end