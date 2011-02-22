require 'jschematic/element'

module Jschematic
  module Composite
    include Enumerable
    include Jschematic::Element

    def children
      @children ||= []
    end

    def add_child(child)
      child.parent = self
      children << child
    end

    def each(&block)
      block.call(self)
      children.each{ |child| child.each(&block) }
    end
  end
end
