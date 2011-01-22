require 'jschematic/attributes/attribute'

module Jschematic
  module Attributes
    class MinItems < Attribute
      def initialize(min_items)
        @min_items = min_items
      end

      def accepts?(instance)
        return true unless Array === instance
        instance.length >= @min_items
      end
    end
  end
end
