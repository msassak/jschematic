require 'spec_helper'

module Jschematic
  module Attributes
    describe Type do
      it 'validates numbers"' do
        validator = Type.new("number", 2112)
        validator.should be_valid
      end
    end
  end
end
