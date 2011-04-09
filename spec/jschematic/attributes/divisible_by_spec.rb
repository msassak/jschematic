require 'spec_helper'

module Jschematic
  module Attributes
    describe DivisibleBy do
      subject { DivisibleBy.new(2.0) }
      it { should accept("a string") }
      it { should accept("1.2345")   }
      it { should accept([1,2,3])    }
    end
  end
end
