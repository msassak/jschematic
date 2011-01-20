require 'bundler'
Bundler.setup

require 'rspec'
require 'jschematic'

RSpec::Matchers.define :accept do |instance_value|
  match do |validator|
    begin
      validator.accepts?(instance_value)
    rescue Jschematic::ValidationError
      false
    end
  end
end

