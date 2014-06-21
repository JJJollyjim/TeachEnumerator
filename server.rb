require 'rubygems'
require 'bundler/setup'

require 'sinatra'
require 'json'

require_relative 'db/db'

get '/' do
  'Hello world!'
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

  data['students'].each do |name|
    # Create student in database
    student = Student.create(:name => name)

    # Create testimonial
    testimonial = Testimonial.create()

    # Link the teacher and student vis the testimonial
    teacher.add_testimonial(testimonial)
    student.add_testimonial(testimonial)
  end

  # Respond "usefully"
  "done"
end
