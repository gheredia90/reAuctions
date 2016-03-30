class Auction < ActiveRecord::Base
	
	belongs_to :buyer, class_name: "User"
	has_and_belongs_to_many :suppliers, class_name: "User"
end
