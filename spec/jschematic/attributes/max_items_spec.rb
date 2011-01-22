require 'spec_helper'

module Jschematic
  module Attributes
    describe MaxItems, "with a maximum of two items" do
      subject { MaxItems.new(2) }

      describe "#accepts?" do
        it { should accept([1,2])                           }
        it { should_not accept([1,2,3])                     }
        it { should accept("instance that is not an array") }
      end
    end
  end
end
