#puts 'Exiting for safety...'
#exit

require 'rubygems'
require 'bundler/setup'

require 'aws/ses'

require 'numbers_and_words'

require_relative 'db/db'

ses = AWS::SES::Base.new(
  :access_key_id     => ENV['TE_AWS_SES_KEY_ID'],
  :secret_access_key => ENV['TE_AWS_SES_SECRET_ACCESS_KEY']
)

Teacher.each do |teacher|
  puts "Sending to #{teacher[:email]}:"

  url = "testimonials.kwiius.com/testimonials/#{teacher[:secret]}"

  I18n.enforce_available_locales = false
  number_in_words = I18n.with_locale(:en) { teacher.testimonials.count.to_words }
  number_in_words[0] = number_in_words[0].capitalize

  body =  "<p>Hello #{teacher[:name]}</p>"
  body << "<p>#{number_in_words} students have requested testimonial comments from you this year.</p>"
  body << "<p>To see the names of those students, click on this link (where you will then click on the edit button alongside each student's name in order to write your comments online):</p>"
  body << "<p><a href='#{url}'>#{url}</a></p>"
  body << "<p>You may visit this link at any time to write testimonial comments. (Don't delete this email until you have completed all of the testimonials.)</p>"
  body << "<p>I will be writing each student's final testimonial using your comments as a guide. This means that you do not <i>necessarily</i> need to write full sentences; however, any beautifully-crafted sentences that I can copy and paste will undoubtedly inspire my heart-felt gratitude and may result in chocolates in your pigeonhole!</p>"
  body << "<p>I would appreciate it if these could be completed by Friday the 8th of August (the end of Week 3).</p>"
  body << "<p>Kind regards (and best wishes for a happy holiday)</p>"
  body << "<p>Janet McCallister</p>"

  ses.send_email(
#    :to        => teacher[:email],
    :to        => 'jamie.mcclymont@gmail.com',
    :from      => '"WGC Testimonial System" <janet.mccallister@wgc.school.nz>',
    :subject   => 'Your Year 13 Testimonial Requests',
    :html_body => body
  )
  
  puts "Sent!"
  puts

  sleep 0.2
  
end
