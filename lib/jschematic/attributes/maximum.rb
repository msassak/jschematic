require 'jschematic/element'

module Jschematic
  module Attributes
    class Maximum
      include Jschematic::Element

      attr_reader :maximum

      def initialize(maximum)
        @maximum = maximum
      end

      def accepts?(number)
        return true unless Numeric === number

        (number <= maximum) || fail_validation!("<= #{@maximum}", number)
      end
    end
  end
end
