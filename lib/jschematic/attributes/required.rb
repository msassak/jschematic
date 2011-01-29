require 'jschematic/element'

module Jschematic
  module Attributes
    class Required
      include Jschematic::Element

      def initialize(required=false)
        case required
        when TrueClass, FalseClass
          @required = required
        else
          raise "Require must be strictly true or false. Truthy and false values are not allowed."
        end
      end

      def required?
        @required
      end

      def accepts?(instance)
        if @required
          instance || fail_validation!(@required, instance)
        end
      end
    end
  end
end
