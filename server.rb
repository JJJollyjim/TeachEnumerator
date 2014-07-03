require 'rubygems'
require 'bundler/setup'

require 'sinatra'
require 'json'

require_relative 'db/db'
require_relative 'helpers'
require_relative 'authenticate'

configure do
  set :bind, '0.0.0.0'
end

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

  # Generate the teacher's MD5 secret
  teacher.make_secret

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

get '/testimonials/:secret' do
  authenticate(params[:secret]) do |teacher|
    erb :testimonials, :locals => {
      :teacher_name => teacher.name,
      :testimonials => teacher.testimonials
    }
  end
end

def find_testimonial(teacher, id)
  teacher.testimonials.find{|x| x.id.to_s == id}
end

get '/testimonials/edit/:secret/:id' do
  authenticate(params[:secret]) do |teacher|
    testimonial = find_testimonial(teacher, params[:id])
    
    if testimonial.nil?
      'Testimonial not found'
    else
      erb :edit, :locals => {
        :id           => params[:id],
        :student_name => testimonial.student.name
      }
    end
  end
end

post '/testimonials/submit/:secret/:id' do
  authenticate(params[:secret]) do |teacher|
    testimonial = find_testimonial(teacher, params[:id])

    fields_needing_casting = [ 'rating_independence',
                               'rating_relationships',
                               'rating_maturity',
                               'rating_confidence',
                               'rating_academic'      ]

    fields_not_needing_casting = [ 'comments_independence',
                                   'comments_relationships',
                                   'comments_maturity',
                                   'comments_confidence',
                                   'comments_academic',
                                   'long_comments_general',
                                   'long_comments_known'    ]

    fields_needing_casting.each do |field|
      testimonial.set(field => params[field].to_i)
    end

    fields_not_needing_casting.each do |field|
      testimonial.set(field => params[field])
    end

    testimonial.save
    testimonial.submit


    redirect "/testimonials/#{params[:secret]}"
  end
end

