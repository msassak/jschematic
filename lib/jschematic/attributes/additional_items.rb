require 'jschematic/element'

module Jschematic
  module Attributes
    class AdditionalItems
      include Jschematic::Element

      def initialize(allowed, &block)
        case items = block.call("items")
        when Array
          @allowed = allowed
          @tuple_types_count = items.length
        else
          # TODO spec: additionalItems applies only with tuple-typing, so
          # even if it is set to false we allow anything... should probably raise
          # but the I-D is silent on the proper behavior in that case.
          @allowed = true
        end
      end

      def accepts?(instance)
        return true if TrueClass === @allowed

        case @allowed
        when FalseClass
          (instance.length == @tuple_types_count) || fail_validation!("#{@tuple_types_count} items", "#{instance.length} items")
        when Hash
          schema = Schema.new(@allowed)
          additional = instance[@tuple_types_count..-1]
          additional.all?{ |item| schema.accepts?(item) }
        end
      end
    end
  end
end
