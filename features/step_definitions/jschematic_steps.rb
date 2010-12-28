Given "this JSON:" do |json|
  @json = parse(json)
end

Then "the JSON should conform to this schema:" do |schema|
  @schema = parse(schema)
  assert_valid(@json, @schema)
end

When "this is the schema:" do |schema|
  @schema = parse(schema)
end

Then "this should be acceptable JSON:" do |json|
  @json = parse(json)
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

  def constantize(string)
    Kernel.const_get(string)
  end
end

World(JschematicWorld)
