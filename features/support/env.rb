$:.unshift(File.expand_path(File.dirname(__FILE__) + "/../../lib"))

require 'rspec/expectations'
require 'yajl'
require 'jsonschema'

require 'jschematic'

if ENV['SANITY_CHECK']
  Before do
    @sanity_check = true
  end
end
