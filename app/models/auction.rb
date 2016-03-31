class Auction < ActiveRecord::Base
	
	belongs_to :buyer, class_name: "User"
	has_many :bids
	has_and_belongs_to_many :suppliers, class_name: "User"

	def get_bids
		self.bids.map { |bid| bid.value }
	end
	
	def get_minimum_bid
		self.get_bids.min
	end

	def add_bid(bid)
		self.bids << bid
	end	
end
