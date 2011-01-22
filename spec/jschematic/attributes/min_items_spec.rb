require 'spec_helper'

module Jschematic
  module Attributes
    describe MinItems, "with a minimum of two items" do
      subject { MinItems.new(2) }

      describe "#accepts?" do
        it { should     accept([1,2])                           }
        it { should_not accept([1])                             }
        it { should     accept("instance that is not an array") }
      end
    end
  end
end
