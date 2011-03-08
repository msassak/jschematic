require 'spec_helper'

shared_examples_for "an element" do |args|
  let(:parent) { double("a parent element") }
  let(:good)   { args[:good] }
  let(:bad)    { args[:bad] }

  it "has a parent" do
    element.parent = parent
    element.parent.should === parent
  end

  it "accepts good instance values" do
    element.should accept(good)
  end

  it "does not accept bad instance values" do
    element.should_not accept(bad)
  end

  xit "adds errors to its parent" do
    parent = Parent.new
    element.parent = parent
    element.validate(:garbage)
    parent.errors.should include(some_stuff)
  end
end

module Jschematic
  module Attributes
    describe Enum do
      subject { Enum }

      it "raises unless its schema value is an Array" do
        expect { subject.new("this is allowed, right?") }.to raise_error
        expect { subject.new(["not", "really"]) }.to_not raise_error
      end

      it_should_behave_like "an element", good: 1, bad: 2 do
        let(:element) { subject.new([1]) }
      end
    end
  end
end
