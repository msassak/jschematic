require 'spec_helper'

module Jschematic
  module Attributes
    describe Ref do
      describe "#accepts?" do
        it "fails when the references schema does not exist" do
          Schema.schemas.should be_empty
          ref = Ref.new("does_not_exist")
          expect { ref.accepts?({}) }.to raise_error(Jschematic::SchemaNotFoundError)
        end
      end
    end
  end
end
