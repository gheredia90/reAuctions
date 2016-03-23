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
		params[:questions].each_value {|value| @rfp.questions << Question.find_by_id(value)} 
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
			@rfp.update_questions!(params[:questions])
			flash[:notice] = "Entry updated successfully"
			redirect_to dashboard_path
		else
			flash.now[:errors] = @rfp.errors.full_messages
			render 'edit'
		end
	end
		

	def send_answers
		@rfp = Rfp.find_by_id(params[:id])
		current_user.answers_sent?(@rfp) ? update_answers : create_answers
		redirect_to dashboard_path		
	end

	def create_answers
		params[:answers].each do |key, value|
			@answer = Answer.new
			@answer.question_id = value["question"].to_f
			@answer.text = value["text"]
			@answer.rfp_id = value["rfp"].to_f
			@answer.supplier_id = current_user.id
			@answer.save
		end
	end	

	def update_answers
		params[:answers].each do |key, value|
			@answer = Answer.where("supplier_id = ? and rfp_id = ? and question_id = ?", current_user.id, value["rfp"].to_f, value["question"].to_f)[0]
			@answer.text= value["text"]		
			@answer.save
		end
	end

    def rfp_params
		params.require(:rfp).permit(:title, :description, :category)
	end

end