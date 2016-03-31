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

	def rfps_as_buyer
		Rfp.where(buyer_id: self.id)
	end


	def rfps_as_supplier
		Rfp.joins(:answers).where('answers.supplier_id' => self.id)
	end

	def rfps_available_as_supplier
		Rfp.where(category: self.category)
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
