require 'jschematic/element'

module Jschematic
  module Composite
    include Jschematic::Element

    def children
      @children ||= []
    end

    def add_child(child)
      child.parent = self
      children << child
    end
  end
end
