module Jschematic
  module Attributes
    class Type
      attr_reader :type

      def initialize(type)
        @type = type.capitalize
      end

      def accepts?(instance)
        return true unless type

        case
        when type == "Object"
          instance.instance_of?(Hash)
        when type == "Number"
          [Float, Integer].any? { |klass| instance.kind_of?(klass) }
        when type == "Integer"
          instance.kind_of?(Integer)
        else
          instance.instance_of?(constantize(type))
        end
      end

      private

      def constantize(string)
        Kernel.const_get(string)
      end
    end
  end
end
