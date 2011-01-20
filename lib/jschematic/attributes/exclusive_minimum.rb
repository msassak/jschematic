require 'jschematic/attributes/attribute'

module Jschematic
  module Attributes
    class ExclusiveMinimum < Attribute
      def initialize(enabled, &block)
        @enabled = enabled
        @minimum = block.call("minimum") if block_given?
        raise "'exclusiveMinimum' depends on 'minimum'" unless @minimum
      end

      def accepts?(actual)
        if @enabled
          (actual > @minimum) || fail_validation!("> #{@minimum}", actual)
        end
      end
    end
  end
end
