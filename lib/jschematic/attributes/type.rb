require 'jschematic/attributes/attribute'

module Jschematic
  module Attributes
    class Type < Attribute
      attr_reader :type

      def initialize(type)
        @type = type
      end

      def accepts?(instance)
        return true unless type

        case type
        when /^object$/
          assert_kind_of([Hash], instance)
        when /^number$/
          assert_kind_of([Float, Integer], instance)
        when /^integer$/
          assert_kind_of([Integer], instance)
        when /^boolean$/
          assert_kind_of([TrueClass, FalseClass], instance)
        when /^null$/
          assert_kind_of([NilClass], instance)
        when /^any$/
          true
        when Array # union
          # TODO: this is gross. A specific Union type is likely called for.
          type.any? do |union_type|
            begin
              if String===union_type
                Type.new(union_type).accepts?(instance)
              elsif Hash===union_type
                Schema.new(union_type).accepts?(instance)
              end
            rescue ValidationError
              false
            end
          end
        else 
          # TODO: probably worth just putting in explicit mapping for all 
          # JSON schema types--there are only a few left
          assert_kind_of([constantize(type)], instance)
        end
      end

      def to_s
        "Type attribute '#{type}'"
      end

      private
      
      def assert_kind_of(klassen, instance)
        klassen.any?{ |klass| instance.kind_of?(klass) } || fail_validation!(klassen, instance)
      end

      def constantize(string)
        Kernel.const_get(string.capitalize)
      end
    end
  end
end
