class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
    	t.integer :question_id
    	t.integer :supplier_id
    	t.integer :rfp_id
    	t.text :text

    end
  end
end
