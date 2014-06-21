DB.create_table?(:teachers) do
  primary_key :id
  String      :name,  :null => false
  String      :email, :null => false
end

DB.create_table?(:students) do
  primary_key :id
  String      :name,  :null => false
  String      :email, :null => false
end

DB.create_table?(:testimonials) do
  primary_key :id
  Integer     :student_id, :null => false
  Integer     :teacher_id, :null => false

  TrueClass   :submitted,  :null => false, :default => false
  String      :text,       :text => true
end
