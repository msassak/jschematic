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

    attr_reader :default, :title, :description, :schema, :unknown_attributes

    attr_accessor :name
    attr_writer   :parent

    def initialize(raw_schema)
      @raw_schema  = raw_schema.dup || {}

      @default     = @raw_schema.delete("default")
      @title       = @raw_schema.delete("title") || ""
      @description = @raw_schema.delete("description") || ""
      @schema      = @raw_schema.delete("$schema")
      @id          = Addressable::URI.parse(@raw_schema.delete("id") || "")

      @unknown_attributes = {}

      Context.add_schema(@id, self) unless @id.to_s.empty?

      @raw_schema.each_pair do |attribute, value|
        begin
          attribute = Attributes[attribute].new(value){ |dep| @raw_schema[dep] }
          add_child(attribute)
        rescue NameError => e
          warn "Attribute lookup failed for '#{attribute}' with: #{e.message}" if Jschematic.debug
          @unknown_attributes[attribute] = value
        end
      end
    end

    def accepts?(instance)
      children.all?{ |child| child.accepts?(add_default(instance)) }
    end

    def required?
      children.any?{ |child| child.required? }
    end

    def schema_for(ref)
      Context.schema_for(ref)
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
