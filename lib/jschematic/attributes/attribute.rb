require 'jschematic/validation_error'

module Jschematic
  module Attributes
    class Attribute
      private

      def fail_validation!(expected, actual)
        raise Jschematic::ValidationError.new(self, expected, actual)
      end
    end
  end
end
