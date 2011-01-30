Before('@sanity_check') do
  enable_sanity_check
end

When /^the schema is '(.+)'$/ do |schema|
  @schema = parse(schema)
end

When "the schema is:" do |schema|
  @schema = parse(schema)
end

Then /^'(.+)' is valid JSON$/ do |json|
  @json = parse(json)
  assert_valid(@json, @schema)
end

Then /^'(.+)' is not valid JSON$/ do |json|
  @json = parse(json)
  assert_invalid(@json, @schema)
end

Then "this is valid JSON:" do |json|
  @json = parse(json)
  assert_valid(@json, @schema)
end

Then "this is not valid JSON:" do |json|
  @json = parse(json)
  assert_invalid(@json, @schema)
end

Then "these are valid JSON:" do |instances|
  instances.raw.each do |row|
    assert_valid(parse(row[0]), @schema)
  end
end

Then "these are not valid JSON:" do |instances|
  instances.raw.each do |row|
    assert_invalid(parse(row[0]), @schema)
  end
end

Then /^the id of "(.+)" is "(.+)"$/ do |title, uri|
  schema = find_schema(@schema)
  schema.title.should == title
  schema.id.should == uri
end

module JschematicWorld
  def parse(json)
    Yajl::Parser.parse(json)
  rescue Yajl::ParseError => e
    raise "Parsing '#{json}' failed with #{e.to_s}"
  end

  def assert_valid(json, schema)
    assert_sanity(json, schema, true) if @sanity_check
    Jschematic.validate(json, schema).should be_true
  end

  def assert_invalid(json, schema)
    assert_sanity(json, schema, false) if @sanity_check
    Jschematic.validate(json, schema).should be_false
  end

  def find_schema(raw_schema)
    Jschematic::Schema.new(raw_schema)
  end

  def assert_sanity(json, schema, expect_valid=true)
    JSON::Schema.validate(json, schema)
  rescue JSON::Schema::ValueError => e
    raise e if expect_valid
  end
  
  def enable_sanity_check
    puts "Enabling sanity check"
    @sanity_check = true
  end
end

World(JschematicWorld)
