require 'spec_helper'

module Jschematic
  module Attributes
    describe ExclusiveMaximum do
      subject { ExclusiveMaximum }

      it "raises if maximum is not defined" do
        expect { subject.new(true){|needed| nil} }.to raise_error(/'exclusiveMaximum' depends on 'maximum'/)
      end
    end
  end
end
