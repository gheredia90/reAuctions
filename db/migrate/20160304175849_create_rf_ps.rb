class CreateRfPs < ActiveRecord::Migration
  def change
    create_table :rfps do |t|

    	t.integer :buyer_id
    	t.string :title
    	t.string :description
    	t.string :category
      t.boolean :opened

    end
  end
end
