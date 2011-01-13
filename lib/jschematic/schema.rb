require 'jschematic/attributes'

module Jschematic
  class Schema
    attr_reader :schema

    def initialize(schema)
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
      
      @schema = schema
      @parent = nil
      @children = []

      schema.each_pair do |attribute, value|
        if value.kind_of?(Hash)
          # Must be a schema
          @children << Schema.new(schema[attribute])
        else
          if attribute == "items"
            # handle this
          elsif attribute == "properties"
            # and this
          else
            begin
              attr_class = Attributes.const_get(attribute.capitalize)
              @children << attr_class.new(attribute){ |dep| schema[dep] }
            rescue NameError => e
              # no Atttribute class found
            end
          end
        end
      end
    end

    def accepts?(instance)
      validate(instance)
    end

    def validate(instance)
      [
        type_valid?(schema["type"], instance),
        minimum_valid?(*schema.values_at("minimum", "exclusiveMinimum"), instance),
        maximum_valid?(*schema.values_at("maximum", "exclusiveMaximum"), instance),
        properties_valid?(schema["properties"], instance),
        items_valid?(schema["items"], instance)
      ].all? { |res| res == true }
    end

    def type_valid?(type, json)
      Attributes::Type.new(type).accepts?(json)
    end

    def minimum_valid?(min, exclusive, num)
      Attributes::Minimum.new(min, exclusive).accepts?(num)
    end

    def maximum_valid?(max, exclusive, num)
      Attributes::Maximum.new(max, exclusive).accepts?(num)
    end

    def properties_valid?(schema, json)
      return true unless schema

      schema.all? do |property, schema|
        if json[property]
          type_valid?(schema["type"], json[property]) &&
            maximum_valid?(*schema.values_at("maximum", "exclusiveMaximum"), json[property])
        else
          maximum_valid?(*schema.values_at("maximum", "exclusiveMaximum"), json[property])
        end
      end
    end

    def items_valid?(schema, json)
      return true unless schema
      return true unless json.kind_of?(Array)

      case schema
      when Hash
        json.all?{ |item| Schema.new(schema).validate(item) }
      when Array
        schema.zip(json).all?{ |schema, item| Schema.new(schema).validate(item) }
      end
    end
  end
end
