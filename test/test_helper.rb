$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'minitest/autorun'
require 'dotenv/load'
require 'sens_sms'
require 'minitest/reporters'

Minitest::Reporters.use!(Minitest::Reporters::ProgressReporter.new)
