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
    
    type = schema["type"].capitalize
    klass = case
            when type == "Object"
              Hash
            when type == "Number"
              Float # or Fixnum or Bignum
            when type == "Integer"
              Fixnum # or Bignum 
            else
              constantize(type)
            end

    json.should be_an_instance_of(klass)
  end

  def assert_invalid(json, schema)
    assert_sanity(json, schema, false)
  end

  def assert_sanity(json, schema, expect_valid=true)
    JSON::Schema.validate(json, schema)
  rescue JSON::Schema::ValueError => e
    raise e if expect_valid
  end

  def constantize(string)
    Kernel.const_get(string)
  end
end

World(JschematicWorld)
