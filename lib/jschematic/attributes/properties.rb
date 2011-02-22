require 'jschematic/composite'

module Jschematic
  module Attributes
    class Properties
      include Jschematic::Composite

      def initialize(properties)
        @schemas = properties.inject({}) do |schemas, (name, schema)|
          schemas[name] = Schema.new(schema)
          schemas[name].parent = self
          add_child(schemas[name])
          schemas
        end
      end

      def accepts?(instance)
        @schemas.all? do |name, schema|
          value = instance.fetch(name) do |missing|
            return true unless schema.required?
            fail_validation!(missing, nil) unless schema.default 
            schema.default
          end
          schema.accepts?(value) || fail_validation!(name, value)
        end
      end

      def id
        @parent.id
      end
    end
  end
end
