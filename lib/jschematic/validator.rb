require 'jschematic/schema'

module Jschematic
  class Validator
    attr_reader :schema, :json

    def initialize(schema, json)
      @schema, @json = Schema.new(schema), json
    end

    def valid?
      schema.validate(json)
    end
  end
end
