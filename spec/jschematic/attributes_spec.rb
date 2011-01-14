require 'spec_helper'

module Jschematic
  describe Attributes do
    describe ".[]" do
      it "maps from javascript style names to classes" do
        Attributes::Properties.should_receive(:new).with(1, 2)
        subject["properties"].new(1, 2)
      end
    end
  end
end
