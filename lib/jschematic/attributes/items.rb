require 'jschematic/element'

module Jschematic
  module Attributes
    class Items
      include Jschematic::Element

      def initialize(schema)
        @schema = schema
      end

      def accepts?(instance)
        case @schema
        when Hash
          instance.all?{ |item| Schema.new(@schema).accepts?(item) }
        when Array
          @schema.zip(instance).all?{ |schema, item| Schema.new(schema).accepts?(item) }
            # TODO: There is a bug here similar to the one in the Union type;
            #       the error reported does not mention the failure is w/i an item attribute
        end || fail_validation!(@schema, instance) 
      end
    end
  end
end
