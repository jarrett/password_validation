require 'bundler/setup'
require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use! Minitest::Reporters::DefaultReporter.new

$:.unshift(File.join(File.expand_path(File.dirname(__FILE__)), '../lib'))

require 'password_validation'

class Minitest::Test
  def make_class(validates_password_opts = {})
    klass = Class.new
    klass.class_eval do
      include ActiveModel::Validations
      
      validates :password, password: validates_password_opts
      
      attr_accessor :password
    end
    klass
  end
  
  def make_and_validate_instance(password, validates_password_opts = {})
    obj = make_class(validates_password_opts).new
    obj.password = password
    obj.valid?
    obj
  end
  
  def assert_errors(errors, password, validates_password_opts = {})
    obj = make_and_validate_instance(password, validates_password_opts)
    unless errors.is_a?(Array)
      errors = [errors]
    end
    assert_equal errors, obj.errors[:password]
  end
end
