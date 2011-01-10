When /^the schema is '(.+)'$/ do |schema|
  @schema = parse(schema)
end

When "the schema is:" do |schema|
  @schema = parse(schema)
end

Then /^'(.+)' is acceptable JSON$/ do |json|
  @json = parse(json)
  assert_valid(@json, @schema)
end

Then "this is acceptable JSON:" do |json|
  @json = parse(json)
  assert_valid(@json, @schema)
end

Then /^'(.+)' is not acceptable JSON$/ do |json|
  @json = parse(json)
  assert_invalid(@json, @schema)
end

module JschematicWorld
  def parse(json)
    Yajl::Parser.parse(json)
  rescue Yajl::ParseError => e
    raise "Parsing '#{json}' failed with #{e.to_s}"
  end

  def assert_valid(json, schema)
    assert_sanity(json, schema, true)
    validator = Jschematic::Validator.new(schema, json)
    validator.should be_valid
  end

  def assert_invalid(json, schema)
    assert_sanity(json, schema, false)
    validator = Jschematic::Validator.new(schema, json)
    validator.should_not be_valid
  end

  def assert_sanity(json, schema, expect_valid=true)
    JSON::Schema.validate(json, schema)
  rescue JSON::Schema::ValueError => e
    raise e if expect_valid
  end
end

World(JschematicWorld)
