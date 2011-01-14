module Jschematic
  module Attributes
    class ExclusiveMinimum
      def initialize(enabled, &block)
        @enabled = enabled
        @minimum = block.call("minimum") if block_given?
        raise "'exclusiveMinimum' depends on 'minimum'" unless @minimum
      end

      def accepts?(actual)
        if @enabled
          actual > @minimum
        end
      end
    end
  end
end
