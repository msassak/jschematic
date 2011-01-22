require 'jschematic/attributes/attribute'

module Jschematic
  module Attributes
    class Pattern < Attribute
      def initialize(pattern)
        @pattern = Regexp.new(pattern)
      end

      def accepts?(instance)
        return true unless String === instance
        instance.match(@pattern) || fail_validation!("string matching #{@pattern}", instance)
      end
    end
  end
end
