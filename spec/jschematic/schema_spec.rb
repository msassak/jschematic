require 'spec_helper'

module Jschematic
  describe Schema do
    describe "#required?" do
      it "answers whether when one of its contained elements is required" do
        Schema.new({ "required" => true }).should be_required
        Schema.new({ "required" => false }).should_not be_required
      end
    end

    describe "#title" do
      it "is taken from the raw schema" do
        title = Schema.new({ "title" => "An hero" }).title
        title.should == "An hero"
      end

      it "defaults to an empty string" do
        title = Schema.new({}).title
        title.should == ""
      end
    end

    describe "#description" do
      it "is taken from the raw schema" do
        description = Schema.new({ "description" => "A lengthy diatribe on corn futures" }).description
        description.should == "A lengthy diatribe on corn futures"
      end

      it "defaults to an empty string" do
        description = Schema.new({}).description
        description.should == ""
      end
    end
  end

  class Parent
    attr_reader :id
    def initialize(opts)
      @id = opts["id"]
      @children = []
    end

    def add_child(child)
      child.parent = self
      @children << child
    end
  end

  describe Schema, "as a child element" do
    it "builds its id from its parent" do
      parent = Parent.new("id" => "http://www.example.com/parent/")
      schema = Schema.new("id" => "child")
      parent.add_child(schema)
      schema.id.should == "http://www.example.com/parent/child"
    end
  end
end
