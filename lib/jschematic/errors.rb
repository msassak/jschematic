module Jschematic
  class Errors
    include Enumerable

    def initialize(raise_on_error = false)
      @raise_on_error = raise_on_error
      @errors = []
    end

    def add(id, desc)
      if @raise_on_error
        raise "Error: #{desc}"
      else
        @errors << [id, desc]
      end
    end

    def all
      @errors
    end

    def reset!
      @errors = []
    end

    def each(&block)
      @errors.each(&block)
    end
  end
end
