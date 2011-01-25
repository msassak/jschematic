require 'jschematic/errors'
require 'jschematic/attributes'

module Jschematic
  class Schema
    attr_reader :schema

    def initialize(schema)
      @schema = schema || {}
      @default = schema.delete("default") || {}
      @children = []

      @schema.each_pair do |attribute, value|
        begin
          @children << Attributes[attribute].new(value){ |dep| schema[dep] }
        rescue NameError => e
          # Not finding an attribute is not necessarily an error, but this is
          # obviously not the right way to handle it. Need to find a better way to
          # report information.
          puts "NameError #{e} encountered... continuing"
        end
      end
    end

    def accepts?(instance)
      instance.merge!(@default) if instance.respond_to?(:merge)
      @children.all?{ |child| child.accepts?(instance) }
    end

    def required?
      @children.any?{ |child| child.required? }
    end
  end
end
