class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    has_many :answers, as: :supplier
    has_many :rfps

	def rfps_as_buyer
		Rfp.where(buyer_id: self.id)
	end


	def rfps_as_supplier
		Rfp.joins(:answers).where('answers.supplier_id' => self.id)
	end

	def rfps_available_as_supplier
		Rfp.where(category: self.category)
	end

	def answers_sent?(rfp)
		Answer.where("supplier_id = ? and rfp_id = ?", self.id, rfp.id).length != 0
	end	
end
