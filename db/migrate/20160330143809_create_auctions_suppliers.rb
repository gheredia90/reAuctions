class CreateAuctionsSuppliers < ActiveRecord::Migration
  def change
    create_table :auctions_users do |t|
    	t.integer :auction_id
    	t.integer :user_id
    end
  end
end
