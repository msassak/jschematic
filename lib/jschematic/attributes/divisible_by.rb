require 'jschematic/element'

module Jschematic
  module Attributes
    class DivisibleBy
      include Jschematic::Element

      def initialize(divisor)
        @divisor = divisor
      end

      def accepts?(dividend)
        return true unless Numeric === dividend

        remainder = (dividend % @divisor)
        (remainder == 0) || fail_validation!("#{dividend} modulo #{@divisor} to have a remainder of 0", remainder)
      end
    end
  end
end
