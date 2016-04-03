class Rfp < ActiveRecord::Base
	has_and_belongs_to_many :questions
	has_many :answers
	belongs_to :buyer, class_name: "User"

	def update_questions!(questions)		
		if questions.size > 0
      self.questions = []
			questions.each_value {|value| self.add_question(value)}
			self.save
		end
	end	

	def add_question(value)
		question = Question.find_by_id(value)		
		unless question.in?(self.questions)
			self.questions << question
		end
	end	

	def get_suppliers
		self.answers.map {|answer| answer.supplier}.uniq
	end	

end
