users = User.create([
  {name: 'Ian',  email: 'ian@dischord.com', password: "12345678", role: "Buyer"},
  {name: 'Henry',  email: 'hank@sst.com', password: "12345678", role: "Buyer"},
  {name: 'Glenn', email: 'danzig@plan9.com', password: "12345678", role: "Supplier", category: "Utilities"},
  {name: 'H.R.', email: 'paul@reachoutinternational.com', password: "12345678", role: "Supplier", category: "Facilities"},
  {name: 'Morgensen.', email: 'morgensen@reacal.com', password: "12345678", role: "Supplier", category: "Utilities"},
  {name: 'Cupertino.', email: 'cupertino@reacal.com', password: "12345678", role: "Supplier", category: "Utilities"}

])

q1 = Question.create text: '¿Cuál es la calidad del material?'
q2 = Question.create text: 'Precio por unidad:'
q3 = Question.create text: 'Posibles ofertas a aplicar'
q4 = Question.create text: 'Precio mínimo del lote:'
q5 = Question.create text: 'Tamaño mínimo del lote (n.unidades):'
q6 = Question.create text: 'Servicios adicionales que podrían incluirse en el contrato:'

r1 = Rfp.create title: 'RFP - Ian - Utilities', description: "Test RFP for Utilities by Ian", category: 'Utilities', buyer_id: 1
r1.questions.push(q1, q2, q3, q4)
r2 = Rfp.create title: 'RFP - Henry - Facilities', description: "Test RFP for Facilities by Henry", category: 'Henry', buyer_id: 2
r2.questions.push(q1, q2, q3, q4, q5, q6)

rfps = Rfp.create([
  {title: 'RFP - Ian - Metals', description: "Test RFP for Metals by Ian", category: 'Metals and Minings', buyer_id: 1},
  {title: 'RFP - Ian - Office Consumables', description: "Test RFP for Office Consumables by Ian", category: 'Office Consumables', buyer_id: 1},
  {title: 'RFP - Henry - Utilities', description: "Test RFP for Utilities by Henry", category: 'Utilities', buyer_id: 2},
])

anwers = Answer.create([
  {text: 'Media-baja', question_id: 1, rfp_id: 1, supplier_id: 3},
  {text: '300 euros', question_id: 2, rfp_id: 1, supplier_id: 3},
  {text: 'Ninguna', question_id: 3, rfp_id: 1, supplier_id: 3},
  {text: '20000 euros', question_id: 4, rfp_id: 1, supplier_id: 3},
  {text: 'Media-alta', question_id: 1, rfp_id: 2, supplier_id: 4},
  {text: '80 euros', question_id: 2, rfp_id: 2, supplier_id: 4},
  {text: 'Ninguna', question_id: 3, rfp_id: 2, supplier_id: 4},
  {text: '8000 euros', question_id: 4, rfp_id: 2, supplier_id: 4},
  {text: '100 unidades', question_id: 5, rfp_id: 2, supplier_id: 4},
  {text: '2 años de asistencia técnica', question_id: 6, rfp_id: 2, supplier_id: 4},
  {text: 'Alta', question_id: 1, rfp_id: 1, supplier_id: 5},
  {text: '500 euros', question_id: 2, rfp_id: 1, supplier_id: 5},
  {text: 'Ninguna', question_id: 3, rfp_id: 1, supplier_id: 5},
  {text: '50000 euros', question_id: 4, rfp_id: 1, supplier_id: 5},
  {text: 'Normal', question_id: 1, rfp_id: 1, supplier_id: 6},
  {text: '340 euros', question_id: 2, rfp_id: 1, supplier_id: 6},
  {text: 'Ninguna', question_id: 3, rfp_id: 1, supplier_id: 6},
  {text: '30000 euros', question_id: 4, rfp_id: 1, supplier_id: 6}
])


