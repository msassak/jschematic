require 'jschematic/element'

module Jschematic
  module Attributes
    class PatternProperties
      include Jschematic::Element

      def initialize(schema)
        @schema = schema
      end

      def accepts?(instance)
        instance.all? do |property, value|
          if match = @schema.find{ |re, schema| property =~ Regexp.new(re) }
            Schema.new(match[1]).accepts?(value)
          else
            false
          end
        end || fail_validation!(@schema, instance)
      end
    end
  end
end
