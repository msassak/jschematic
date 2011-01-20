require 'jschematic/attributes/attribute'

module Jschematic
  module Attributes
    class Properties < Attribute
      def initialize(schema)
        @schema = schema
      end

      def accepts?(instance)
        instance.all? do |property, value|
          begin
            Schema.new(@schema[property]).accepts?(value)
          rescue ValidationError
            false
          end
        end || fail_validation!(@schema, instance)
      end
    end
  end
end
