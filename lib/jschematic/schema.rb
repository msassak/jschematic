require 'jschematic/errors'
require 'jschematic/element'
require 'jschematic/attributes'

module Jschematic
  class Schema
    include Enumerable
    include Jschematic::Element

    attr_reader :default, :title, :description, :id

    def initialize(raw_schema)
      @raw_schema  = raw_schema.dup || {}

      @default     = @raw_schema.delete("default")
      @title       = @raw_schema.delete("title") || ""
      @description = @raw_schema.delete("description") || ""
      @id          = @raw_schema.delete("id") || ""

      @attributes = []

      @raw_schema.each_pair do |attribute, value|
        begin
          @attributes << Attributes[attribute].new(value){ |dep| @raw_schema[dep] }
        rescue NameError => e
          # Not finding an attribute is not necessarily an error, but this is
          # obviously not the right way to handle it. Need to find a better way to
          # report information.
          # should we create accessors for property on the schema?
          # we could have Attributes.[] raise a special exception rather than NameError
          puts "NameError #{e} encountered... continuing"
        end
      end
    end

    def accepts?(instance)
      @attributes.all?{ |child| child.accepts?(add_default(instance)) }
    end

    def required?
      @attributes.any?{ |child| child.required? }
    end

    def each(&block)
      block.call(self)
      @attributes.each{ |child| child.each(&block) }
    end

    private

    def add_default(instance)
      return instance unless default

      case instance
      when Hash
        @default.keys.each do |key|
          instance[key] = @default[key] unless instance.has_key?(key)
        end
      end

      instance
    end
  end
end
