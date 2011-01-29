require 'jschematic/element'

module Jschematic
  module Attributes
    class Dependencies
      include Jschematic::Element

      def initialize(dependencies)
        @dependencies = dependencies
      end

      def accepts?(instance)
        instance.keys.all? do |property|
          case deps = @dependencies[property]
          when String, Array
            [deps].flatten.all?{ |req| instance.keys.include?(req) }
          when Hash
            Schema.new(deps).accepts?(instance)
          else
            true
          end
        end
      end
    end
  end
end
