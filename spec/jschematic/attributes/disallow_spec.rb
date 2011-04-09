require 'spec_helper'

module Jschematic
  module Attributes
    describe Disallow do
      subject { Disallow.new("any") }
      it { should_not accept("a string") }
      it { should_not accept(1234) }
      it { should_not accept(1.234) }
      it { should_not accept([1,2,3]) }
      it { should_not accept({"foo" => "bar"}) }
      it { should_not accept(true) }
    end
  end
end
