module Jschematic
  module Attributes
    class ExclusiveMaximum
      def initialize(enabled, &block)
        @enabled = enabled
        @maximum = block.call("maximum") if block_given?
        raise "'exclusiveMaximum' depends on 'maximum'" unless @maximum
      end

      def accepts?(actual)
        if @enabled
          actual < @maximum
        end
      end
    end
  end
end
