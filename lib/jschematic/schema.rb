require 'jschematic/attributes'

module Jschematic
  class Schema
    attr_reader :schema

    def initialize(schema, parent=nil)
      @schema = schema || {}
      @parent = parent
      @children = []

      @schema.each_pair do |attribute, value|
        if attribute == "properties"
          @children << Attributes::Properties.new(value)
        elsif attribute == "items"
          @children << Attributes::Items.new(value)
        elsif value.kind_of?(Hash)
          # begin
          #   get attribute
          # rescue NameError
          #   Must be a schema
          # end
          @children << Schema.new(schema[attribute], self)
        else
          begin
            attr_class = Attributes.const_get(attribute.capitalize)
            @children << attr_class.new(value){ |dep| schema[dep] }
          rescue NameError => e
            # no Atttribute class found
          end
        end
      end
    end

    def accepts?(instance)
      @children.all?{ |child| child.accepts?(instance) }
    end
  end
end
