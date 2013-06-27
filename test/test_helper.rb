# Set up simplecov
require 'simplecov'
require 'simplecov-rcov'
SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
SimpleCov.start 'rails'

# Setup turn
require 'turn/autorun'
require 'ansi'
Turn.config do |conf|
  conf.format = :outline
  conf.verbose = true
  conf.trace = nil
  conf.natural = true
  conf.ansi = true
end

require 'mocha/setup'
require 'ostruct'
require 'pry'

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load the app
require File.expand_path("../../lib/holla_back.rb", __FILE__)
