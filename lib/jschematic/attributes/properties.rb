require 'jschematic/composite'

module Jschematic
  module Attributes
    class Properties
      include Jschematic::Composite

      def initialize(properties)
        properties.each_pair do |name, raw_schema|
          schema = Schema.with_name(raw_schema, name)
          add_child(schema)
        end
      end

      def accepts?(instance)
        children.all? do |child|
          match = find_instance_for(instance, child.name)

          if match
            value = match.last
          else
            value = nil
          end

          if !value and child.default
            value = child.default
          end

          if !value and child.required?
            fail_validation!("#{child.name} is required", nil)
          elsif !value
            true
          else
            child.accepts?(value) || fail_validation!(child.name, value)
          end
        end
      end

      def id
        @parent.id
      end

      private

      def find_instance_for(instance, wanted_name)
        instance.find do |property_name, _|
          property_name == wanted_name
        end
      end
    end
  end
end
