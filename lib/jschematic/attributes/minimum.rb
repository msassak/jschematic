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
        return true unless minimum
        return true unless (number.kind_of?(Integer) || number.kind_of?(Float))

        (number >= minimum) || fail_validation!(">= #{@minimum}", number)
      end
    end
  end
end
