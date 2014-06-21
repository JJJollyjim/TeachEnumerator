require 'sequel'

DB = Sequel.connect(ENV['TE_SQL'])

require_relative 'tables'
require_relative 'models'
