module Jschematic
  module Attributes
    class Disallow < Type
      # disallow inverts the type attribute, so it succeeds if type fails
      def accepts?(instance)
        inverted = begin
          super or fail_validation!("instance not to be of type '#{type}'", instance)
          false
        rescue ValidationError
          true
        end
        inverted || fail_validation!("instance not to be of type '#{type}'", instance)
      end
    end
  end
end
