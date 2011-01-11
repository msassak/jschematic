require 'jschematic/schema'

module Jschematic
  class Validator
    attr_reader :schema, :json

    def initialize(schema, json)
      @schema, @json = schema, json
    end

    def valid?
      Schema.new(schema, json).valid?
    end
  end
end
