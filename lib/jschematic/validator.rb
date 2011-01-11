require 'jschematic/attributes/type'

module Jschematic
  class Validator
    attr_reader :schema, :json

    def initialize(schema, json)
      @schema, @json = schema, json
    end

    def valid?
      [
        type_valid?(schema["type"], json),
        minimum_valid?(*schema.values_at("minimum", "exclusiveMinimum"), json),
        maximum_valid?(*schema.values_at("maximum", "exclusiveMaximum"), json),
        properties_valid?(schema["properties"], json)
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
