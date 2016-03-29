class Question < ActiveRecord::Base
	has_and_belongs_to_many :rfps
	has_many :answers

	def get_answers(rfp)
		self.answers.where(rfp_id: rfp.id)
	end	

end
