class Auction < ActiveRecord::Base
	
	belongs_to :buyer, class_name: "User"
	has_many :suppliers, class_name: "User"
end
