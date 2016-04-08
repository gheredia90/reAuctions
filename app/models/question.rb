class Question < ActiveRecord::Base
	has_and_belongs_to_many :rfps
	has_many :answers

	def get_answers(rfp)
		self.answers.where(rfp_id: rfp.id)
	end	

	def text_answer_for_rfp_and_user(rfp, user)
		answer = self.answers.where(supplier_id: user.id, rfp_id: rfp.id).first
		answer.present? ? answer.text : ""
	end	

end
