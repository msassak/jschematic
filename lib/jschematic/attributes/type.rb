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
          assert_kind_of([Float, Integer], instance)
        when /^integer$/
          instance.kind_of?(Integer)
        when /^boolean$/
          assert_kind_of([TrueClass, FalseClass], instance)
        when /^null$/
          assert_kind_of([NilClass], instance)
        when /^any$/
          true
        when Array # union
          type.any? do |union_type|
            if String===union_type
              Type.new(union_type).accepts?(instance)
            elsif Hash===union_type
              Schema.new(union_type).accepts?(instance)
            end
          end
        else 
          # TODO: probably worth just putting in explicit mapping for all 
          # JSON schema types--there are only a few left
          instance.instance_of?(constantize(type))
        end
      end

      private

      def constantize(string)
        Kernel.const_get(string.capitalize)
      end

      def assert_kind_of(klassen, instance)
        klassen.any?{ |klass| instance.kind_of?(klass) }
      end
    end
  end
end
