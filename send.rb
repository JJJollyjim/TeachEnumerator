require 'rubygems'
require 'bundler/setup'

require 'aws/ses'

require_relative 'db/db'

ses = AWS::SES::Base.new(
  :access_key_id     => "AKIAJQWGTHQGTBDHLJDA",
  :secret_access_key => "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"
)

Teacher.each do |teacher|

  puts "Sending to #{teacher[:email]}:"

  body = "Hello, #{teacher[:name]}," + "<br><br>" +
         "Here are the students who have requested testimonials from you this year:" + "<br>" +
         "<ul>"

  names = teacher.testimonials.map do |test|
    test.student[:name]
  end

  names.each do |name|
    body << "<li>" + name + "</li>"
  end

  body << "</ul>" + "<br><br>" +
          "<small>This is an automated system. Please report faults to jamie@kwiius.com</small>"

  ses.send_email(
    :to        => teacher[:email],
    :from      => '"WGC Testimonial System" <janet.mccallister@wgc.school.nz>',
    :subject   => 'Your Student Testimonial Applications',
    :html_body => body
  )
  
  puts "Sent!"
  puts

  sleep 0.2
  
end


