require 'bundler'
Bundler.setup

require 'rspec'
require 'jschematic'

RSpec::Matchers.define :accept do |instance_value|
  match do |validator|
    validator.accepts?(instance_value)
  end
end

