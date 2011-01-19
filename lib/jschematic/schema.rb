require 'jschematic/errors'
require 'jschematic/attributes'

module Jschematic
  class Schema
    attr_reader :schema

    def initialize(schema)
      @schema = schema || {}
      @children = []

      @schema.each_pair do |attribute, value|
        begin
          @children << Attributes[attribute].new(value){ |dep| schema[dep] }
        rescue NameError => e
          # Not finding an attribute is not necessarily a failure, so 
          # we should not fail, but we may need to mark it someplace...
          # Unsure what to do in this case. 
        end
      end
    end

    def accepts?(instance)
      @children.all?{ |child| child.accepts?(instance) }
    end
  end
end
