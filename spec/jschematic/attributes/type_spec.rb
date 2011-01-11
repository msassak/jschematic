require 'spec_helper'

module Jschematic
  module Attributes
    describe Type do
      context "string" do
        subject { Type.new("string") }
        it { should_not accept(nil) }
      end

      context "number" do
        subject { Type.new("number") }
        it { should_not accept(nil) }
        it { should accept(2112) }
      end

      context "integer" do 
        subject { Type.new("integer") }
        it { should_not accept(nil) }
      end

      context "boolean" do
        subject { Type.new("boolean") }
        it { should_not accept(nil) }
        it { should_not accept("true") }
        it { should_not accept([1,2,3]) }
      end

      context "object" do
        subject { Type.new("object") }
        it { should_not accept(nil) }
        it { should_not accept([1,2,3]) }
        it { should_not accept("string") }
      end

      context "array" do
        subject { Type.new("array") }
        it { should_not accept(nil) }
        it { should_not accept({:foo => "bar"}) }
        it { should_not accept(1234) }
      end

      context "null" do
        subject { Type.new("null") }
        it { should accept(nil) }
        it { should_not accept(true) }
        it { should_not accept("string") }
        it { should_not accept([1,2,3]) }
      end

      context "any" do
        subject { Type.new("null") }
        it { should accept(nil) }
      end
    end
  end
end

