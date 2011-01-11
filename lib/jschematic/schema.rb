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
        properties_valid?(schema["properties"], instance)
      ].all? { |res| res == true }
    end

    def type_valid?(type, json)
      Attributes::Type.new(type, json).valid?
    end

    def minimum_valid?(min, exclusive, num)
      return true unless min
      return true unless (num.kind_of?(Integer) || num.kind_of?(Float))

      if exclusive
        num > min
      else
        num >= min
      end
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
        type_valid?(schema["type"], json[property]) &&
          maximum_valid?(*schema.values_at("maximum", "exclusiveMaximum"), json[property])
      end
    end
  end
end
