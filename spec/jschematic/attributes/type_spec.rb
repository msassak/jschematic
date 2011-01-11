require 'spec_helper'

module Jschematic
  module Attributes
    describe Type do
      context "number" do
        subject { Type.new("number") }
        it { should accept(2112) }
        it { should_not accept(nil) }
      end
    end
  end
end

