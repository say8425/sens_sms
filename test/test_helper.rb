$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'dotenv/load'
require 'sens_sms'
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use!(Minitest::Reporters::ProgressReporter.new)
