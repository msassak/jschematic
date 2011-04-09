require 'jschematic/context'

module Jschematic
  def self.validate(instance, schema, opts={})
    validate!(instance, schema, opts)
  rescue ValidationError
    false
  end

  def self.validate!(instance, schema, opts={})
    Context.new(*opts[:context]).validate!(instance, schema)
  end

  class << self
    attr_accessor :debug
  end
end
