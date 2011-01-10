module Jschematic
  class Validator
    attr_reader :schema, :json

    def initialize(schema, json)
      @schema, @json = schema, json
    end

    def valid?
      type = schema["type"].capitalize
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

    private

    def constantize(string)
      Kernel.const_get(string)
    end
  end
end
