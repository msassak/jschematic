module Jschematic
  module Attributes
    class Maximum
      attr_reader :maximum, :exclusive

      def initialize(maximum, exclusive=true, &callback)
        @maximum, @exclusive = maximum, exclusive
        @exclusive = callback.call("exclusiveMaximum") if block_given?
      end
      
      def accepts?(number)
        return true unless maximum
        return true unless (number.kind_of?(Integer) || number.kind_of?(Float))

        if exclusive
          number < maximum
        else
          number <= maximum
        end
      end
    end
  end
end
