require 'jschematic/attributes/type'
require 'jschematic/attributes/properties'
require 'jschematic/attributes/pattern_properties'
require 'jschematic/attributes/additional_properties'
require 'jschematic/attributes/items'
require 'jschematic/attributes/required'
require 'jschematic/attributes/minimum'
require 'jschematic/attributes/maximum'
require 'jschematic/attributes/exclusive_minimum'
require 'jschematic/attributes/exclusive_maximum'
require 'jschematic/attributes/min_items'
require 'jschematic/attributes/max_items'
require 'jschematic/attributes/unique_items'
require 'jschematic/attributes/min_length'
require 'jschematic/attributes/max_length'

module Jschematic
  module Attributes
    def self.[](name)
      const_get(name[0].chr.capitalize + name[1..-1])
    end
  end
end
