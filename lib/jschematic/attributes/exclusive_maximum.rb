module Jschematic
  module Attributes
    class ExclusiveMaximum
      def initialize(enabled, &block)
        @enabled = enabled
        @maximum = block.call("maximum")
        raise "exclusiveMaximum requires maximum to be defined" unless @maximum
      end

      def accepts?(actual)
        if @enabled
          actual < @maximum
        end
      end
    end
  end
end
