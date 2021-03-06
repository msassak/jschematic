require 'jschematic/schema'

module Jschematic
  class Context
    def self.schema_for(ref)
      if ref.relative?
        rel = ref.omit(:scheme, :host, :port)
        if match = schemas.find{ |ref, _| rel == ref.omit(:scheme, :host, :port) }
          match[-1]
        end
      else
        schemas[ref]
      end
    end

    def self.add_schema(id, schema)
      schemas[id] = schema
    end

    def self.schemas
      @schemas ||= {}
    end

    def self.empty
      new
    end

    def initialize(*raw_schemas)
      @schemas = raw_schemas.collect{ |raw_schema| Schema.new(raw_schema) }
    end

    def validate!(instance, raw_schema)
      Schema.new(raw_schema).accepts?(instance)
    end

    def add_schema(id, schema)
      self.class.add_schema(id, schema)
    end

    def schema_for(ref)
      self.class.schema_for(ref)
    end
  end
end
