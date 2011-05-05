require 'jschematic/exceptions'

module Jschematic
  module Element
    attr_accessor :parent
    attr_writer   :id

    def required?
      false
    end

    def title
      nil
    end

    def id
      if @parent.respond_to?(:id)
        @parent.id + @id
      else
        @id
      end
    end

    def to_s
      self.class.to_s
    end

    def schema_for(ref)
      parent && parent.schema_for(ref)
    end

    private

    def fail_validation!(expected, actual)
      raise Jschematic::ValidationError.new(self, expected, actual)
    end
  end
end
