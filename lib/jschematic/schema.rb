require 'jschematic/errors'
require 'jschematic/element'
require 'jschematic/attributes'

module Jschematic
  class Schema
    include Jschematic::Element

    attr_reader :default, :title, :description, :id

    def initialize(schema)
      @schema = schema || {}
      @default = schema.delete("default")
      @title = schema.delete("title") || ""
      @description = schema.delete("description") || ""
      @id = schema.delete("id") || ""
      @children = []

      @schema.each_pair do |attribute, value|
        begin
          @children << Attributes[attribute].new(value){ |dep| @schema[dep] }
        rescue NameError => e
          # Not finding an attribute is not necessarily an error, but this is
          # obviously not the right way to handle it. Need to find a better way to
          # report information.
          puts "NameError #{e} encountered... continuing"
        end
      end
    end

    def accepts?(instance)
      @children.all?{ |child| child.accepts?(add_default(instance)) }
    end

    def required?
      @children.any?{ |child| child.required? }
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
