class Rfp < ActiveRecord::Base
	has_and_belongs_to_many :questions
	has_many :answers
	belongs_to :buyer, class_name: "User"
end
