module Jschematic
  module Attributes
    class Minimum 
      attr_reader :minimum

      def initialize(minimum)
        @minimum = minimum
      end

      def accepts?(number)
        return true unless minimum
        return true unless (number.kind_of?(Integer) || number.kind_of?(Float))

        number >= minimum
      end
    end
  end
end
