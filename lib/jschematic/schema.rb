require 'jschematic/attributes'

module Jschematic
  class Schema
    attr_reader :schema

    def initialize(schema, parent=nil)
      @schema = schema || {}
      @parent = parent
      @children = []

      @schema.each_pair do |attribute, value|
        begin
          attr_class = Attributes.const_get(attribute.capitalize)
          @children << attr_class.new(value){ |dep| schema[dep] }
        rescue NameError => e
          # no attribute class found -- do something about that
        end
      end
    end

    def accepts?(instance)
      @children.all?{ |child| child.accepts?(instance) }
    end
  end
end
