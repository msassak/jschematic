require 'spec_helper'

module Jschematic
  describe Errors do
    let(:errors) { Errors.new }

    it "is enumerable" do
      errors.class.should include(Enumerable)

      errors.add(:ident1, "desc1")
      errors.add(:ident2, "desc2")

      col = []
      errors.each{ |error| col << error }

      col.should == [[:ident1, "desc1"], [:ident2, "desc2"]]
    end

    describe "#add" do
      it "records an error" do
        errors.add(:ident, "description")
        errors.all.should == [[:ident, "description"]]
      end

      context "when raise on error is true" do
        let(:errors) { Errors.new(true) }

        it "raises when an error is added" do
          expect { errors.add(:ident, "description") }.to raise_error(/Error: description/)
        end
      end
    end

    describe "#reset!" do
      it "clears the collected errors" do
        errors.add(:ident, "desc")
        errors.should_not be_empty
        errors.reset!
        errors.should be_empty
      end
    end
  end
end
