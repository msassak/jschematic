require 'spec_helper'

module Jschematic
  module Attributes
    describe Required do
      describe "#required?" do
        subject { Required }

        context "by default" do
          it "answers false" do
            subject.new.should_not be_required
          end
        end

        context "when true" do
          it "answers true" do
            subject.new(true).should be_required
          end
        end

        context "when truthy or falsy" do
          it "raises an error" do
            expect { subject.new("true") }.to raise_error
          end
        end
      end
    end
  end
end
