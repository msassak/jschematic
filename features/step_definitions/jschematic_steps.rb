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
  assert_valid(parse(json), @schema)
end

Then /^'(.+)' is not valid JSON$/ do |json|
  assert_invalid(parse(json), @schema)
end

Then "this is valid JSON:" do |json|
  assert_valid(parse(json), @schema)
end

Then "this is not valid JSON:" do |json|
  assert_invalid(parse(json), @schema)
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
  schema = build_schema.find{ |el| el.title == title }
  [schema.title, schema.id].should == [title, uri]
end

module JschematicWorld
  def parse(json)
    Yajl::Parser.parse(json)
  rescue Yajl::ParseError => e
    raise "Parsing '#{json}' failed with #{e.to_s}"
  end

  def assert_valid(json, raw_schema)
    assert_sanity(json, raw_schema, true) if @sanity_check
    Jschematic.validate(json, raw_schema).should be_true
  end

  def assert_invalid(json, raw_schema)
    assert_sanity(json, schema, false) if @sanity_check
    Jschematic.validate(json, raw_schema).should be_false
  end

  def build_schema
    @_schema ||= Jschematic::Schema.new(@schema)
  end

  def assert_sanity(json, raw_schema, expect_valid=true)
    JSON::Schema.validate(json, raw_schema)
  rescue JSON::Schema::ValueError => e
    raise e if expect_valid
  end
  
  def enable_sanity_check
    puts "Enabling sanity check"
    @sanity_check = true
  end
end

World(JschematicWorld)
