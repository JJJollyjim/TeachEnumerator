DB.create_table?(:teachers) do
  primary_key :id
  String :code_and_name
  String :email
end

DB.create_table?(:students) do
  primary_key :id
  String :name
end

DB.create_table?(:testimonials) do
	primary_key :id
  Integer :student_id
  Integer :teacher_id
end
