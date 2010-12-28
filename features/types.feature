Feature: Schema Types
  Scenario: string
    When the schema is '{ "type": "string" }'
    Then '"hello, world"' should be acceptable JSON

  Scenario: object
    When the schema is '{ "type": "object" }'
    Then this JSON should be acceptable:
      """
      { "person": "felizberto" }
      """

  Scenario: array
    When the schema is '{ "type": "array" }'
    Then this JSON should be acceptable:
      """
      ["foo", "bar", "baz"]
      """

  Scenario: number
    When the schema is '{ "type": "number" }'
    Then '3.14159' should be acceptable JSON
    
  Scenario: integer
    When the schema is '{ "type": "integer" }'
    Then '2112' should be acceptable JSON
