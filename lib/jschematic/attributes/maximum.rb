module Jschematic
  module Attributes
    class Maximum
      attr_reader :maximum

      def initialize(maximum)
        @maximum = maximum
      end
      
      def accepts?(number)
        return true unless maximum
        return true unless (number.kind_of?(Integer) || number.kind_of?(Float))

        number <= maximum
      end
    end
  end
end
