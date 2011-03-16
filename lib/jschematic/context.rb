require 'jschematic/schema'

module Jschematic
  class Context
    def initialize(*schemas)
      @schemas = schemas.collect{ |raw_schema| Schema.new(raw_schema) }
    end

    def validate!(instance)
      @schemas.last.accepts?(instance)
    end
  end
end
