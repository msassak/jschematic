Gem::Specification.new do |s|
  s.name        = 'jschematic'
  s.version     = '0.0.5'
  s.authors     = ["Mike Sassak"]
  s.description = "JSON Schema v3 Validator"
  s.summary     = "jschematic #{s.version}"
  s.email       = "msassak@gmail.com"
  s.homepage    = "https://github.com/msassak/jschematic"

  s.add_dependency 'addressable'

  s.add_development_dependency 'cucumber'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'yajl-ruby'

  s.rubygems_version   = "1.3.7"
  s.files            = `git ls-files`.split("\n")
  s.test_files       = `git ls-files -- {spec,features}/*`.split("\n")
  s.extra_rdoc_files = ["LICENSE", "README.md"]
  s.rdoc_options     = ["--charset=UTF-8"]
  s.require_path     = "lib"
end
