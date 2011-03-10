require 'addressable/uri'

require 'jschematic/element'

module Jschematic
  module Attributes
    class Ref
      include Jschematic::Element

      def initialize(uri)
        @uri = Addressable::URI.parse(uri)
      end

      def accepts?(instance)
        schema = Schema.schema_for(@uri) || raise(SchemaNotFoundError.new(@uri))
        schema.accepts?(instance)
      end
    end
  end
end
