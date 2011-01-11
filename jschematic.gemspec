Gem::Specification.new do |s|
  s.name        = 'jschematic'
  s.version     = '0.0.1'
  s.authors     = ["Mike Sassak"]
  s.description = "JSON Schema v3 Validator"
  s.homepage    = "https://github.com/msassak/jschematic"

  s.add_development_dependency 'cucumber'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'yajl-ruby'
  s.add_development_dependency 'jsonschema'
end
