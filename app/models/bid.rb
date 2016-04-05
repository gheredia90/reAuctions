class Bid < ActiveRecord::Base
	belongs_to :auction
	belongs_to :supplier, class_name: "User"
  
  def <=>(other)
    self.value <=> other.value
  end
	
end
