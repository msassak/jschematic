Feature: Schema Types
  Scenario: string
    When the schema is '{ "type": "string" }'
    Then '"hello, world"' is valid JSON

  Scenario: number
    TODO: test an integer is valid as well:
    "And '2112' is valid JSON"
    --- 
    When the schema is '{ "type": "number" }'
    Then '3.14159' is valid JSON

  Scenario: integer
    TODO: test that floats are not allowed:
    "And '3.14159' is not valid JSON"
    ---
    When the schema is '{ "type": "integer" }'
    Then '2112' is valid JSON

  Scenario: object
    When the schema is '{ "type": "object" }'
    Then this is valid JSON:
      """
      { "person": "felizberto" }
      """

  Scenario: array
    When the schema is '{ "type": "array" }'
    Then this is valid JSON:
      """
      ["foo", "bar", "baz"]
      """

  Scenario: null
  Scenario: any
  Scenario: union
