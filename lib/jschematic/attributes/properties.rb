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
          value = instance.fetch(child.name) do |missing|
            return true unless child.required?
            fail_validation!(missing, nil) unless child.default
            child.default
          end
          child.accepts?(value) || fail_validation!(child.name, value)
        end
      end

      def id
        @parent.id
      end
    end
  end
end
