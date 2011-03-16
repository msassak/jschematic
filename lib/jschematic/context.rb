require 'jschematic/schema'

module Jschematic
  class Context
    def initialize(*raw_schemas)
      @schemas = raw_schemas.collect{ |raw_schema| Schema.new(raw_schema) }
    end

    def validate!(instance, raw_schema)
      Schema.new(raw_schema).accepts?(instance)
    end
  end
end
