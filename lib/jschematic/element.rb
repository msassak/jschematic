require 'jschematic/validation_error'

module Jschematic
  module Element
    def required?
      false
    end

    def title
      nil
    end

    def to_s
      self.class.to_s
    end

    private

    def fail_validation!(expected, actual)
      raise Jschematic::ValidationError.new(self, expected, actual)
    end
  end
end
