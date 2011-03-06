require 'spec_helper'

module Jschematic
  module Attributes
    describe Format do
      it "returns a NullFormat when the format is not found" do
        format = Format.new("i-don't-exist")
        format.should be_an_instance_of(Format::NullFormat)
        format.format.should == "i-don't-exist"
      end
    end
  end
end
