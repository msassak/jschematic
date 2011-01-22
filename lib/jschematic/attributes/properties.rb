require 'jschematic/attributes/attribute'

module Jschematic
  module Attributes
    class Properties < Attribute
      def initialize(properties)
        @schemas = properties.inject({}) do |schemas, (name, schema)|
          schemas[name] = Schema.new(schema)
          schemas
        end
      end

      def accepts?(instance)
        @schemas.all? do |name, schema|
          value = instance.fetch(name) do |missing|
            return true unless schema.required?
            fail_validation!(missing, nil)
          end
          schema.accepts?(value) || fail_validation!(name, value)
        end
      end
    end
  end
end
