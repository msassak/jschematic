require 'jschematic/element'

module Jschematic
  module Attributes
    class UniqueItems
      include Jschematic::Element

      def initialize(value=false)
        @value = value
      end

      def accepts?(instance)
        require true unless Array === instance
        (instance == instance.uniq) || fail_validation!("all items to be unique", instance)
      end
    end
  end
end
