require 'jschematic/element'

module Jschematic
  module Attributes
    class Minimum
      include Jschematic::Element

      attr_reader :minimum

      def initialize(minimum)
        @minimum = minimum
      end

      def accepts?(number)
        return true unless Numeric === number

        (number >= minimum) || fail_validation!(">= #{@minimum}", number)
      end
    end
  end
end
