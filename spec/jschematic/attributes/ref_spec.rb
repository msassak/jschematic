require 'spec_helper'

module Jschematic
  module Attributes
    describe Ref do
      describe "#accepts?" do
        it "fails when the referenced schema does not exist" do
          ref = Ref.new("does_not_exist")
          expect { ref.accepts?({}) }.to raise_error(Jschematic::SchemaNotFoundError)
        end
      end
    end
  end
end
