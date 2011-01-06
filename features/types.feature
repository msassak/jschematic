Feature: Schema Types
  Scenario: string
    When the schema is '{ "type": "string" }'
    Then '"hello, world"' should be acceptable JSON

  Scenario: number
    TODO: test an integer here as well:
    "And '2112' should be acceptable JSON"
    --- 
    When the schema is '{ "type": "number" }'
    Then '3.14159' should be acceptable JSON

  Scenario: integer
    TODO: test that floats are not allowed:
    "And '3.14159' should not be acceptable JSON"
    ---
    When the schema is '{ "type": "integer" }'
    Then '2112' should be acceptable JSON

  Scenario: object
    When the schema is '{ "type": "object" }'
    Then this should be acceptable JSON:
      """
      { "person": "felizberto" }
      """

  Scenario: array
    When the schema is '{ "type": "array" }'
    Then this should be acceptable JSON:
      """
      ["foo", "bar", "baz"]
      """

  Scenario: null
  Scenario: any
  Scenario: union
