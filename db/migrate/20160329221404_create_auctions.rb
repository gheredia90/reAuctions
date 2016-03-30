class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|

    	t.integer :buyer_id
    	t.string :title
    	t.string :description
    	t.boolean :opened
    	t.integer :lowest_bid
    	t.timestamps null: false
    end
  end
end
