require 'spec_helper'

module Jschematic
  module Attributes
    describe Type do
      context "number" do
        subject { Type.new("number") }
        it { should accept(2112) }
        it { should_not accept(nil) }
      end

      context "boolean" do
        subject { Type.new("boolean") }
        it { should_not accept(nil) }
        it { should_not accept("true") }
        it { should_not accept([1,2,3]) }
      end
    end
  end
end

