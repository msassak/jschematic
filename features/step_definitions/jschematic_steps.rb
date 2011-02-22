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
  [schema.title, schema.id.to_s].should == [title, uri]
end

module JschematicWorld
  def parse(json)
    Yajl::Parser.parse(json)
  rescue Yajl::ParseError => e
    raise "Parsing '#{json}' failed with #{e.to_s}"
  end

  def assert_valid(json, raw_schema)
    Jschematic.validate(json, raw_schema).should be_true
  end

  def assert_invalid(json, raw_schema)
    Jschematic.validate(json, raw_schema).should be_false
  end

  def build_schema
    @_schema ||= Jschematic::Schema.new(@schema)
  end
end

World(JschematicWorld)
