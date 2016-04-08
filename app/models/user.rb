class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :trackable, :validatable

  has_many :answers, as: :supplier
  has_many :rfps
  has_many :auctions, as: :buyer
  has_many :bids, as: :supplier
  has_and_belongs_to_many :auctions, as: :supplier

	def rfps_as_buyer(title)
		if title
			Rfp.where("buyer_id = ? and title LIKE ?", self.id, "%#{title}%")
		else
			Rfp.where(buyer_id: self.id)
		end
	end


	def rfps_as_supplier
		Rfp.joins(:answers).where('answers.supplier_id' => self.id)
	end

	def rfps_available_as_supplier(title)
		if title
			Rfp.where("category = ? and title LIKE ?", self.category, "%#{title}%")
		else
			Rfp.where(category: self.category)
		end
		
	end

	def auctions_as_buyer
		Auction.where(buyer_id: self.id)
	end

	def auctions_available_as_supplier
		Auction.joins(:suppliers).where('auctions_users.user_id' => self.id)
	end

	def answers_sent?(rfp)
		Answer.where("supplier_id = ? and rfp_id = ?", self.id, rfp.id).length != 0
	end	
end
