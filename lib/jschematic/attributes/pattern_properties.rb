require 'jschematic/attributes/properties'

module Jschematic
  module Attributes
    class PatternProperties < Properties

      private

      def find_instance_for(instance, wanted_name)
        instance.find do |property_name, _|
          property_name =~ Regexp.new(wanted_name)
        end
      end
    end
  end
end
