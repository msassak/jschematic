Feature: Schema Types
  Scenario: string
    When the schema is '{ "type": "string" }'
    Then '"hello, world"' is acceptable JSON

  Scenario: number
    TODO: test an integer is valid as well:
    "And '2112' is acceptable JSON"
    --- 
    When the schema is '{ "type": "number" }'
    Then '3.14159' is acceptable JSON

  Scenario: integer
    TODO: test that floats are not allowed:
    "And '3.14159' is not acceptable JSON"
    ---
    When the schema is '{ "type": "integer" }'
    Then '2112' is acceptable JSON

  Scenario: object
    When the schema is '{ "type": "object" }'
    Then this is acceptable JSON:
      """
      { "person": "felizberto" }
      """

  Scenario: array
    When the schema is '{ "type": "array" }'
    Then this is acceptable JSON:
      """
      ["foo", "bar", "baz"]
      """

  Scenario: null
  Scenario: any
  Scenario: union
