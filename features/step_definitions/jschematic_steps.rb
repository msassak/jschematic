Given "the validation context contains this schema:" do |schema|
  add_context_schema(schema)
end

When /^the schema is '(.+)'$/ do |schema|
  set_schema(schema)
end

When "the schema is:" do |schema|
  set_schema(schema)
end

Then /^'(.+)' is valid JSON$/ do |json|
  assert_valid(parse(json), current_schema, context_schemas)
end

Then /^'(.+)' is not valid JSON$/ do |json|
  assert_invalid(parse(json), current_schema, context_schemas)
end

Then "this is valid JSON:" do |json|
  assert_valid(parse(json), current_schema, context_schemas)
end

Then "this is not valid JSON:" do |json|
  assert_invalid(parse(json), current_schema, context_schemas)
end

Then "these are valid JSON:" do |instances|
  instances.raw.each do |row|
    assert_valid(parse(row[0]), current_schema, context_schemas)
  end
end

Then "these are not valid JSON:" do |instances|
  instances.raw.each do |row|
    assert_invalid(parse(row[0]), current_schema, context_schemas)
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

  def assert_valid(json, current_schema, context_schemas)
    Jschematic.validate(json, current_schema, :context => context_schemas).should be_true
  end

  def assert_invalid(json, current_schema, context_schemas)
    Jschematic.validate(json, current_schema, :context => context_schemas).should be_false
  end

  def build_schema
    Jschematic::Schema.new(current_schema)
  end

  def set_schema(schema)
    @_schema = parse(schema)
  end

  def current_schema
    @_schema ||= nil
  end

  def add_context_schema(schema)
    context_schemas << parse(schema)
  end

  def context_schemas
    @_context_schemas ||= []
  end
end

World(JschematicWorld)
