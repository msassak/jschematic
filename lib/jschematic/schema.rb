require 'jschematic/attributes'

module Jschematic
  class Schema
    attr_reader :schema

    def initialize(schema, parent=nil)
      #def recur_hash(hash, acc)
      #  hash.each_pair do |key, value|
      #    if Hash===value
      #      acc << "#{key} is a hash!"
      #      recur_hash(hash[key], acc)
      #    else
      #      acc << "#{key} has value: #{value}"
      #    end
      #  end
      #  acc.flatten
      #end

      #h = {
      #  "foo" => "bar",
      #  "baz" => [1,2,3],
      #  :elements => {
      #    "another_thing" => "fooble",
      #    "type" => "integer",
      #    "values" => [1,2,3,4,5],
      #    "properties" => {
      #      "type" => :array,
      #      "name" => "maglarble"
      #    }
      #  }
      #}

      #p recur_hash(h, [])
      
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
