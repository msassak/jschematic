require 'addressable/uri'

require 'jschematic/errors'
require 'jschematic/composite'
require 'jschematic/attributes'

module Jschematic
  class Schema
    include Jschematic::Composite

    # TODO: Spec
    def self.with_name(raw_schema, name)
      schema = new(raw_schema)
      schema.name = name
      schema
    end

    attr_reader :default, :title, :description

    attr_accessor :name
    attr_writer   :parent

    def initialize(raw_schema)
      @raw_schema  = raw_schema.dup || {}

      @default     = @raw_schema.delete("default")
      @title       = @raw_schema.delete("title") || ""
      @description = @raw_schema.delete("description") || ""
      @id          = Addressable::URI.parse(@raw_schema.delete("id") || "")

      @raw_schema.each_pair do |attribute, value|
        begin
          attribute = Attributes[attribute].new(value){ |dep| @raw_schema[dep] }
          add_child(attribute)
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
      children.all?{ |child| child.accepts?(add_default(instance)) }
    end

    def required?
      children.any?{ |child| child.required? }
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
