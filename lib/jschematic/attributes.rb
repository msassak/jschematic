require 'jschematic/attributes/type'
require 'jschematic/attributes/properties'
require 'jschematic/attributes/pattern_properties'
require 'jschematic/attributes/additional_properties'
require 'jschematic/attributes/items'
require 'jschematic/attributes/additional_items'
require 'jschematic/attributes/required'
require 'jschematic/attributes/dependencies'
require 'jschematic/attributes/minimum'
require 'jschematic/attributes/maximum'
require 'jschematic/attributes/exclusive_minimum'
require 'jschematic/attributes/exclusive_maximum'
require 'jschematic/attributes/min_items'
require 'jschematic/attributes/max_items'
require 'jschematic/attributes/unique_items'
require 'jschematic/attributes/pattern'
require 'jschematic/attributes/min_length'
require 'jschematic/attributes/max_length'
require 'jschematic/attributes/enum'
require 'jschematic/attributes/format'
require 'jschematic/attributes/divisible_by'
require 'jschematic/attributes/disallow'
require 'jschematic/attributes/ref'

module Jschematic
  module Attributes
    def self.[](name)
      name_without_meta = name.gsub(/^\$/, '')
      const_get(name_without_meta[0].chr.capitalize + name_without_meta[1..-1])
    end
  end
end
