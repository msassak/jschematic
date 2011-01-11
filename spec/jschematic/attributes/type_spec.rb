require 'spec_helper'

module Jschematic
  module Attributes
    describe Type do
      context "number" do
        it "accepts integer instance values" do
          validator = Type.new("number")
          validator.should accept(2112)
        end

        it "rejects null instance values" do
          validator = Type.new("number")
          validator.should_not accept(nil)
        end
      end
    end
  end
end

