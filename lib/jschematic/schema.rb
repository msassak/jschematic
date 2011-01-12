require 'jschematic/attributes'

module Jschematic
  class Schema
    attr_reader :schema

    def initialize(schema)
      @schema = schema
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
      #return true unless min
      #return true unless (num.kind_of?(Integer) || num.kind_of?(Float))

      #if exclusive
        #num > min
      #else
        #num >= min
      #end
      Attributes::Minimum.new(min, exclusive).accepts?(num)
    end

    def maximum_valid?(max, exclusive, num)
      return true unless max
      return true unless (num.kind_of?(Integer) || num.kind_of?(Float))

      if exclusive
        num < max
      else
        num <= max
      end
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

      json.all?{ |item| Schema.new(schema).validate(item) }
    end
  end
end
