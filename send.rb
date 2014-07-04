#puts 'Exiting for safety...'
#exit

require 'rubygems'
require 'bundler/setup'

require 'aws/ses'

require_relative 'db/db'

ses = AWS::SES::Base.new(
  :access_key_id     => ENV['TE_AWS_SES_KEY_ID'],
  :secret_access_key => ENV['TE_AWS_SES_SECRET_ACCESS_KEY']
)

Teacher.each do |teacher|
  puts "Sending to #{teacher[:email]}:"

  url = "testimonials.kwiius.com/testimonials/#{teacher[:secret]}"

  body =  "<p>Hello #{teacher[:name]},</p>"
  body << "<p>#{teacher.testimonials.count} students have requested testimonials from you this year.</p>"
  body << "<p>Here is your testimonial link:</p>"
  body << "<p><a href='#{url}'>#{url}</a></p>"
  body << "<p>You may visit this link at any time to write your testimonials up until Friday the 8th of August (the end of Week 3)</p>"


#         "Here are the students who have requested testimonials from you this year:" + "<br>" +
#         "<ul>"
#
#  names = teacher.testimonials.map do |test|
#    test.student[:name]
#  end
#
#  names.each do |name|
#    body << "<li>" + name + "</li>"
#  end
#
#  body << "</ul>" + "<br><br>" +
#          "<small>This is an automated system. Please report faults to jamie@kwiius.com</small>"

  ses.send_email(
#    :to        => teacher[:email],
    :to        => 'jamie.mcclymont@gmail.com',
    :from      => '"WGC Testimonial System" <janet.mccallister@wgc.school.nz>',
    :subject   => 'Your Student Testimonial Applications',
    :html_body => body
  )
  
  puts "Sent!"
  puts

  sleep 0.2
  
end
