module Jschematic
  module Attributes
    class Maximum
      attr_reader :maximum, :exclusive

      def initialize(maximum, exclusive=true)
        @maximum, @exclusive = maximum, exclusive
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
