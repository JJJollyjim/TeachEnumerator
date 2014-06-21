require 'sequel'

DB = Sequel.connect('sqlite://' + File.join(File.dirname(__FILE__), 'teachenumerator.sqlite'))

require_relative 'tables'
require_relative 'models'
