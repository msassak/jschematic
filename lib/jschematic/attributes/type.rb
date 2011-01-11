module Jschematic
  module Attributes
    class Type
      attr_reader :type

      def initialize(type)
        @type = type
      end

      def accepts?(instance)
        return true unless type

        case type
        when /^object$/
          instance.instance_of?(Hash)
        when /^number$/
          [Float, Integer].any? { |klass| instance.kind_of?(klass) }
        when /^integer$/
          instance.kind_of?(Integer)
        when /^boolean$/
          [TrueClass, FalseClass].any? { |klass| instance.kind_of?(klass) }
        else
          instance.instance_of?(constantize(type))
        end
      end

      private

      def constantize(string)
        Kernel.const_get(string.capitalize)
      end
    end
  end
end
