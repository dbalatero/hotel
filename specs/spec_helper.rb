require 'simplecov'
SimpleCov.start

require 'time'
require 'date'
require 'awesome_print'
require 'pry'


require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/admin'
require_relative '../lib/room'
require_relative '../lib/reservation'
