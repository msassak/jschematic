require 'spec_helper'

module Jschematic
  describe Attributes do
    describe ".[]" do
      it "maps from javascript style names to classes" do
        Attributes::ExclusiveMaximum.should_receive(:new).with(1, 2)
        subject["exclusiveMaximum"].new(1, 2)
      end

      it "strips leading '$'" do
        Attributes::Ref.should_receive(:new).with("foo")
        subject["$ref"].new("foo")
      end
    end
  end
end
