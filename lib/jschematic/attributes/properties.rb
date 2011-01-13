module Jschematic
  module Attributes
    class Properties
      def initialize(schema)
        @schema = schema
      end

      def accepts?(instance)
        instance.all? do |property, value|
          Schema.new(@schema[property]).accepts?(value)
        end
      end
    end
  end
end
