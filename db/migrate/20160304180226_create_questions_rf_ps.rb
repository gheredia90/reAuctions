class CreateQuestionsRfPs < ActiveRecord::Migration
  def change
    create_table :questions_rfps do |t|
    	t.integer :rfp_id
    	t.integer :question_id
    end
  end
end
