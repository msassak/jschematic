require 'jschematic/attributes/attribute'

module Jschematic
  module Attributes
    class AdditionalProperties < Attribute
      # TODO: rename value to allowed
      def initialize(value, &block)
        @value = value
        @properties = block.call("properties").keys
      end

      def accepts?(instance)
        case @value
        when FalseClass
          (@properties == instance.keys) || fail_validation!(@properties, instance.keys)
        when Hash
          schema = Schema.new(@value)
          additional = instance.select{ |attribute, value| !@properties.include?(attribute) }
          additional.all? do |attribute, value|
            schema.accepts?(value)
          end || fail_validation!(@value, instance)
        end
      end
    end
  end
end
