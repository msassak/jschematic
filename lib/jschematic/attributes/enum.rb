require 'jschematic/element'

module Jschematic
  module Attributes
    class Enum
      include Jschematic::Element

      def initialize(enum)
        raise "Enum requires an Array of possible values" unless Array === enum
        @enum = enum
      end

      def accepts?(instance)
        @enum.any?{ |e| e == instance } || fail_validation!("one of #{@enum}", instance)
      end
    end
  end
end
