require 'rubygems'
require 'bundler/setup'

require 'aws/ses'

ses = AWS::SES::Base.new(
  :access_key_id     => "AKIAJQWGTHQGTBDHLJDA",
  :secret_access_key => "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"
)

Dir.entries(ARGV[0]).reject{|x| x == "." or x == ".."}.each do |fn|
  names = File.read(ARGV[0]+"/"+fn).lines.map(&:chomp)
  email = names.shift
  
  puts "Sending to #{email} (not really):"

  body = "Hello, #{fn}," + "<br><br>" +
         "Here are the students who have requested testimonials from you this year:" + "<br>" +
         "<ul>"

  names.each do |name|
    body << "<li>" + name + "</li>"
  end

  body << "</ul>" + "<br><br>" +
          "<small>This is an automated system. Please report faults to jamie@kwiius.com</small>"

  ses.send_email(
    :to        => 'jamie.mcclymont@gmail.com',
    :from      => '"WGC Testimonial System" <janet.mccallister@wgc.school.nz>',
    :subject   => 'Your Student Testimonial Applications',
    :html_body => body
  )
  
  puts "Sent!"
  puts

  sleep 0.2
  
end


