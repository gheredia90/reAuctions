class Answer < ActiveRecord::Base
	belongs_to :question
	belongs_to :rfp
	belongs_to :supplier, class_name: "User"
end
