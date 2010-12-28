Feature: Schema Types
  Scenario: string
    When the schema is '{ "type": "string" }'
    Then '"hello, world"' should be correct JSON

  Scenario: object
    When the schema is:
      """
      { "type": "object" }
      """
    Then this JSON should be correct:
      """
      { "person": "felizberto" }
      """

  Scenario: array
    When the schema is:
      """
      { "type": "array" }
      """
    Then this JSON should be correct:
      """
      ["foo", "bar", "baz"]
      """

  Scenario: number
    When the schema is:
      """
      { "type": "number" }
      """
    Then this JSON should be correct:
      """
      3.14159
      """
    
  Scenario: integer
    When the schema is: 
      """
      { "type": "integer" }
      """
    Then this JSON should be correct:
      """
      2112
      """

