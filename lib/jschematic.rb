require 'jschematic/schema'

module Jschematic
  def self.validate(instance, schema)
    Schema.new(schema).accepts?(instance)
  end
end
