require 'jschematic/attributes/attribute'

module Jschematic
  module Attributes
    class MaxItems < Attribute
      def initialize(max_items)
        @max_items = max_items
      end

      def accepts?(instance)
        return true unless Array === instance
        (instance.length <= @max_items) || fail_validation!("at most #{@max_items}", instance.length)
      end
    end
  end
end
