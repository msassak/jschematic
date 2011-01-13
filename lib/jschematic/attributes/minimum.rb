module Jschematic
  module Attributes
    class Minimum 
      attr_reader :minimum, :exclusive

      def initialize(minimum, exclusive=true, &callback)
        @minimum, @exclusive = minimum, exclusive
        @exclusive = callback.call if block_given?
      end

      def accepts?(number)
        return true unless minimum
        return true unless (number.kind_of?(Integer) || number.kind_of?(Float))

        if exclusive
          number > minimum
        else
          number >= minimum
        end
      end
    end
  end
end
