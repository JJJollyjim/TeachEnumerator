require 'sinatra'
require 'json'

get '/' do
  'Hello world!'
end

post '/send' do
  # Incase someone else has read it
  request.body.rewind

  # Read the response body
  data = JSON.parse request.body.read

  # Open a file with the teacher's name as the filename
  File.open "data/#{data["tname"]}", "w" do |f|

    # Write the email address and list of students to file
    f.write(data["temail"] + "\n" + data["students"].join("\n"))

  end

  # Respond "usefully"
  "done"
end
