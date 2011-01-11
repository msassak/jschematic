@sanity_check
Feature: Core Schema: type
  TODO: (the primitives listed above do not allow nulls on their own)

  Scenario: string
    When the schema is '{ "type": "string" }'
    Then '"hello, world"' is valid JSON

  Scenario: number
    When the schema is '{ "type": "number" }'
    Then '3.14159' is valid JSON
    And '2112' is valid JSON

  Scenario: integer
    When the schema is '{ "type": "integer" }'
    Then '2112' is valid JSON
    But '3.14159' is not valid JSON

  Scenario: boolean
    When the schema is '{ "type": "boolean" }'
    Then 'true' is valid JSON
    And 'false' is valid JSON

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
