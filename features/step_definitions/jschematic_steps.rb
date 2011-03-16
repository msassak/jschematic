Given "this schema:" do |schema|
  add_schema(parse(schema))
end

When /^the schema is '(.+)'$/ do |schema|
  add_schema(parse(schema))
end

When "the schema is:" do |schema|
  add_schema(parse(schema))
end

Then /^'(.+)' is valid JSON$/ do |json|
  assert_valid(parse(json), all_schemas)
end

Then /^'(.+)' is not valid JSON$/ do |json|
  assert_invalid(parse(json), all_schemas)
end

Then "this is valid JSON:" do |json|
  assert_valid(parse(json), all_schemas)
end

Then "this is not valid JSON:" do |json|
  assert_invalid(parse(json), all_schemas)
end

Then "these are valid JSON:" do |instances|
  instances.raw.each do |row|
    assert_valid(parse(row[0]), all_schemas)
  end
end

Then "these are not valid JSON:" do |instances|
  instances.raw.each do |row|
    assert_invalid(parse(row[0]), all_schemas)
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

  def assert_valid(json, raw_schemas)
    Jschematic.validate(json, *raw_schemas).should be_true
  end

  def assert_invalid(json, raw_schemas)
    Jschematic.validate(json, *raw_schemas).should be_false
  end

  def build_schema
    @_schema ||= Jschematic::Schema.new(all_schemas.first)
  end

  def add_schema(schema)
    @_schemas ||= []
    @_schemas << schema
  end

  def all_schemas
    @_schemas ||= []
  end
end

World(JschematicWorld)
