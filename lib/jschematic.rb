require 'jschematic/schema'

module Jschematic
  def self.validate(instance, schema)
    validate!(instance, schema)
  rescue ValidationError
    false
  end

  def self.validate!(instance, schema)
    Schema.new(schema).accepts?(instance)
  end
end
