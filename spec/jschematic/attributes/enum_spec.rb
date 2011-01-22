require 'spec_helper'

module Jschematic
  module Attributes
    describe Enum do
      subject { Enum }

      it "raises unless its schema value is an Array" do
        expect { subject.new("this is allowed, right?") }.to raise_error
        expect { subject.new(["not", "really"]) }.to_not raise_error
      end
    end
  end
end
