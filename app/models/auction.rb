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

  def set_lowest_bid
    self.lowest_bid = self.get_minimum_bid
  end 

  def get_lowest_bid_supplier
    supplier_id = self.sort_bids.first.supplier_id
    User.find_by_id(supplier_id)
  end  

	def add_bid(bid)
		self.bids << bid
	end	

  def has_bids?
    self.bids.length > 0
  end

  def get_bids_by_supplier(supplier)
    bids = self.bids.select{|bid| bid.supplier_id == supplier.id}
    bids.map { |bid| bid.value }
  end 

  def sort_bids
     self.bids.sort { |a,b| a.value <=> b.value } 
  end  
  
  def get_start_date_ms
    self.start_date.to_f*1000
  end

  def get_end_date_ms
    self.end_date.to_f*1000
  end 


end
