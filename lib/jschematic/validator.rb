module Jschematic
  class Validator
    attr_reader :schema, :json

    def initialize(schema, json)
      @schema, @json = schema, json
    end

    def valid?
      [
        type_valid?(schema["type"], json),
        properties_valid?(schema["properties"], json)
      ].all? { |res| res == true }
    end

    def type_valid?(type, json)
      return true unless type # always pass if type doesn't exist
      type.capitalize!
      klass = case
              when type == "Object"
                Hash
              when type == "Number"
                Float # or Fixnum or Bignum
              when type == "Integer"
                Fixnum # or Bignum 
              else
                constantize(type)
              end
      json.instance_of?(klass)
    end

    def maximum_valid?(max, num)
      return true unless max
      num <= max
    end

    def properties_valid?(schema, json)
      return true unless schema

      schema.all? do |property, schema|
        type_valid?(schema["type"], json[property]) &&
          maximum_valid?(schema["maximum"], json[property])
      end
    end

    private

    def constantize(string)
      Kernel.const_get(string)
    end
  end
end
