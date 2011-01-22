module Jschematic
  class ValidationError < StandardError
    attr_reader :what, :expected, :actual

    def initialize(what, expected, actual)
      @what, @expected, @actual = what, expected, actual
    end

    def to_s
      "#{what} expected #{expected} but found #{actual}"
    end
  end
end
