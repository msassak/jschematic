$:.unshift(File.expand_path(File.dirname(__FILE__) + "/../../lib"))

require 'rspec/expectations'
require 'yajl'
require 'jsonschema'

require 'jschematic'

if ENV['SANITY_CHECK']
  Before do
    enable_sanity_check
  end
end
