class Teacher < Sequel::Model
  one_to_many :testimonials
end

class Student < Sequel::Model
  one_to_many :testimonials
end

class Testimonial < Sequel::Model
  many_to_one :teacher
  many_to_one :student
end

