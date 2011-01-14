require 'jschematic/attributes/type'
require 'jschematic/attributes/properties'
require 'jschematic/attributes/minimum'
require 'jschematic/attributes/maximum'
require 'jschematic/attributes/exclusive_maximum'
require 'jschematic/attributes/items'

module Jschematic
  module Attributes
    def self.[](name)
      const_get(name[0].chr.capitalize + name[1..-1])
    end
  end
end
