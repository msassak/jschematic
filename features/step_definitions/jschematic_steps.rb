Given /^this JSON:$/ do |json|
  @json = parse(json)
end

Then /^the JSON should conform to this schema:$/ do |schema|
  @schema = parse(schema)
  assert_valid(@json, @schema)
end

module JschematicWorld
  def parse(json)
    Yajl::Parser.parse(json)
  rescue Yajl::ParseError => e
    raise "Parsing '#{json}' failed with #{e.to_s}"
  end

  def assert_valid(json, schema)
    JSON::Schema.validate(json, schema) # sanity check
    json.should be_a_kind_of(constantize(schema["type"].capitalize))
  end

  def constantize(string)
    Kernel.const_get(string)
  end
end

World(JschematicWorld)
