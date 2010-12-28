Feature: Schema Types
  Scenario: string
    Given this JSON:
      """
      "hello, world"
      """
    Then the JSON should conform to this schema:
      """
      { "type": "string" }
      """

  Scenario: object
    When this is the schema:
      """
      { "type": "object" }
      """
    Then this should be acceptable JSON:
      """
      { "person": "felizberto" }
      """

  Scenario: array
    Given this JSON:
      """
      ["foo", "bar", "baz"]
      """
    Then the JSON should conform to this schema:
      """
      { "type": "array" }
      """

  Scenario: number
    Given this JSON:
      """
      3.14159
      """
    Then the JSON should conform to this schema:
      """
      { "type": "number" }
      """

  Scenario: integer
    Given this JSON:
      """
      2112
      """
    Then the JSON should conform to this schema:
      """
      { "type": "integer" }
      """
