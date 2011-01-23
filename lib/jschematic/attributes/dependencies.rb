require 'jschematic/attributes/attribute'

module Jschematic
  module Attributes
    class Dependencies < Attribute
      def initialize(dependencies)
        @dependencies = dependencies
      end

      def dependencies
        @dependencies.collect do |key, value|
          [value].flatten.collect do |req|
            [key, req]
          end
        end.first
      end

      def accepts?(instance)
        properties = instance.keys
        dependencies.all? do |dependent, requirement|
          properties.include?(dependent) && properties.include?(requirement)
        end
      end
    end
  end
end
