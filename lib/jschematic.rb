require 'jschematic/context'

module Jschematic
  def self.validate(instance, *schemas)
    validate!(instance, *schemas)
  rescue ValidationError
    false
  end

  def self.validate!(instance, *schemas)
    Context.new(*schemas).validate!(instance)
  end
end
