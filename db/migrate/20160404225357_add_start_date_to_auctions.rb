class AddStartDateToAuctions < ActiveRecord::Migration
  def change
    add_column :auctions, :start_date, :datetime
    add_column :auctions, :end_date, :datetime
    add_column :auctions, :duration, :integer
  end
end
