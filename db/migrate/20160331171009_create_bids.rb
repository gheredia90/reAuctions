class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
    	t.integer :value
    	t.integer :auction_id
    	t.integer :supplier_id
    end
  end
end
