class Teacher < Sequel::Model
  one_to_many :testimonials

  def num_testimonials_submitted
    self.testimonials.count &:submitted
  end
end

class Student < Sequel::Model
  one_to_many :testimonials

  def num_testimonials_submitted
    self.testimonials.count &:submitted
  end
end

class Testimonial < Sequel::Model
  many_to_one :teacher
  many_to_one :student

  def submit
    self.update(:submitted => true)
  end
end

