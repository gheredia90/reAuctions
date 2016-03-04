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

end
