require 'spec_helper'

module Jschematic
  describe Schema do
    describe "#required?" do
      it "answers whether when one of its contained elements is required" do
        Schema.new({ "required" => true }).should be_required
        Schema.new({ "required" => false }).should_not be_required
      end
    end
  end
end
