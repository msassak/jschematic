require 'addressable/uri'

require 'jschematic/element'

module Jschematic
  module Attributes
    class Extends
      include Jschematic::Element

      def initialize(id_or_schema_or_array_of_schemas)
        @schema = id_or_schema_or_array_of_schemas
      end

      def accepts?(instance)
        case @schema
        when String
          uri = Addressable::URI.parse(@schema)
          schema = Schema.schema_for(uri)
          schema.accepts?(instance)
        when Hash
          Schema.new(@schema).accepts?(instance)
        when Array
          @schema.all? do |schema|
            Extends.new(schema).accepts?(instance)
          end
        end || fail_validation!(@schema, instance)
      end
    end
  end
end
