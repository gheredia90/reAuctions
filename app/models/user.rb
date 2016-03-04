class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


def rfps_as_buyer
	Rfp.where(buyer_id: self.id)
end


def rfps_as_supplier
	Rfp.join(:answers).where(supplier_id: self.id).uniq
end


end
