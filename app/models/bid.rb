class Bid < ActiveRecord::Base
	belongs_to :auction
	belongs_to :supplier, class_name: "User"
  
  def <=>(other)
    self.value <=> other.value
  end

  def set_data(value, auction_id, current_user_id)
    self.value = value
    self.auction_id = auction_id
    self.supplier_id = current_user_id
    self.save 
  end 

  def get_supplier_name
    User.find_by_id(self.supplier_id).name
  end  
	
end
