require 'jschematic/attributes/type'
require 'jschematic/attributes/properties'
require 'jschematic/attributes/minimum'
require 'jschematic/attributes/maximum'
require 'jschematic/attributes/items'

module Jschematic
  module Attributes
    def self.[](name)
      const_get(name.capitalize)
    end
  end
end
