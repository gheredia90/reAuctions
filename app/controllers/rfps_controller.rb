class RfpsController < ApplicationController

	def new
		@rfp = Rfp.new		
	end

	def create
		@rfp = Rfp.new rfp_params			
		if !params[:questions].nil?
      params[:questions].each_value {|value| @rfp.questions << Question.find_by_id(value)}
      @rfp.buyer = current_user 
      @rfp.opened = true
      @rfp.save
      flash[:alert] = ""
			redirect_to dashboard_path			
		else
      flash[:alert] = "Select at least one question"
			redirect_to new_rfp_path
		end
	end

	def show
		@rfp = Rfp.find_by_id(params[:id])
    gon.role = current_user.role		
		if current_user.role == 'Buyer'
	      render 'rfp_buyer_display'
	    else
	      render 'rfp_supplier_display'
	    end
	end

	def edit
		@rfp = Rfp.find params[:id]
	end

	def update
		@rfp = Rfp.find params[:id]
		if @rfp.update_attributes(rfp_params) && !params[:questions].nil?
			@rfp.update_questions!(params[:questions])
      flash[:alert] = ""
			redirect_to dashboard_path
		else
      flash[:alert] = "Select at least one question"
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
      add_answer(value["question"].to_f, value["text"], value["rfp"].to_f, current_user.id)			
		end
	end	

  def add_answer(question_id, text, rfp_id, supplier_id)
    @answer = Answer.new
    @answer.question_id = question_id
    @answer.text = text
    @answer.rfp_id = rfp_id
    @answer.supplier_id = supplier_id
    @answer.save
  end  

	def update_answers
    @rfp = Rfp.find_by_id(params[:id])
		params[:answers].each do |key, value|
			@answer = Answer.where("supplier_id = ? and rfp_id = ? and question_id = ?", current_user.id, value["rfp"].to_f, value["question"].to_f).first
      if @rfp.answers.include?(@answer)
        @answer.text = value["text"]   
        @answer.save
      else  
        add_answer(value["question"].to_f, value["text"], value["rfp"].to_f, current_user.id) 			   
		  end
    end  
	end

	private
  def rfp_params
		params.require(:rfp).permit(:title, :description, :category)
	end

end