class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :rfp
  belongs_to :supplier, class_name: "User"


  def set_data(question_id, text, rfp_id, supplier_id)
    self.question_id = question_id
    self.text = text
    self.rfp_id = rfp_id
    self.supplier_id = supplier_id
    self.save
  end  
end
