class Rfp < ActiveRecord::Base
	has_and_belongs_to_many :questions
	has_many :answers
	belongs_to :buyer, class_name: "User"

  def set_data(current_user)
    self.buyer = current_user 
    self.opened = true
    self.save
  end  

	def update_questions!(questions)		
		if questions.size > 0
      self.questions = []
			questions.each_value {|value| self.add_question(value)}
			self.save
		end
	end	

	def add_question(value)
		question = Question.find_by_id(value)		
		self.questions << question unless question.in?(self.questions)
	end	

	def get_suppliers
		self.answers.map {|answer| answer.supplier}.uniq
	end	

end
