require 'time'
require 'date'
require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'



Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/admin'
require_relative '../lib/room'
require_relative '../lib/reservation'
