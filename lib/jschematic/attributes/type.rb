module Jschematic
  module Attributes
    class Type
      attr_reader :type, :instance

      def initialize(type, instance)
        @type, @instance = type, instance
      end

      def valid?
        return true unless type

        type.capitalize!
        klass = case
                when type == "Object"
                  Hash
                when type == "Number"
                  Float # or Fixnum or Bignum
                when type == "Integer"
                  Fixnum # or Bignum 
                else
                  constantize(type)
                end
        instance.instance_of?(klass)
      end

      private

      def constantize(string)
        Kernel.const_get(string)
      end
    end
  end
end
