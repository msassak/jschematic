require 'jschematic/attributes/attribute'

module Jschematic
  module Attributes
    class Required < Attribute
      def initialize(required=false)
        @required = required
      end

      def accepts?(instance)
        if @required
          instance || fail_validation!(@required, instance)
        end
      end
    end
  end
end
