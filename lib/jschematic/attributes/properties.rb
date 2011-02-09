require 'jschematic/element'

module Jschematic
  module Attributes
    class Properties
      include Jschematic::Element

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
            fail_validation!(missing, nil) unless schema.default 
            schema.default
          end
          schema.accepts?(value) || fail_validation!(name, value)
        end
      end

      def each(&block)
        @schemas.values.each do |schema|
          block.call(schema)
        end
      end
    end
  end
end
