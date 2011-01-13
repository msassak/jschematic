module Jschematic
  module Attributes
    class Items
      def initialize(schema)
        @schema = schema
      end

      def accepts?(instance)
        case @schema
        when Hash
          instance.all?{ |item| Schema.new(@schema).accepts?(item) }
        when Array
          @schema.zip(instance).all?{ |schema, item| Schema.new(schema).accepts?(item) }
        end
      end
    end
  end
end
