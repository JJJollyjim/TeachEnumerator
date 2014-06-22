require 'rubygems'
require 'bundler/setup'

require 'sinatra'
require 'json'

require_relative 'db/db'

get '/' do
  erb :index
end

post '/send' do
  # Incase someone else has read it
  request.body.rewind

  # Read the response body
  data = JSON.parse request.body.read

  # Create teacher in database
  teacher = Teacher.create(
    :name  => data['tname'],
    :email => data['temail']
  )

  data['students'].each do |student|
    # Create student in database
    if Student.where(:email => student['email']).count == 0
      student = Student.create(
        :name  => student['name'],
        :email => student['email']
      )
    else
      student = Student.where(:email => student['email']).first
    end

    # Create testimonial
    testimonial = Testimonial.create()

    # Link the teacher and student vis the testimonial
    teacher.add_testimonial(testimonial)
    student.add_testimonial(testimonial)
  end

  # Respond "usefully"
  "done"
end
