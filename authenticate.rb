def authenticate(secret)
  teacher = Teacher.where(:secret => secret).first

  if teacher.nil? then
    'Error: secret not found'
  else
    yield teacher
  end
end
