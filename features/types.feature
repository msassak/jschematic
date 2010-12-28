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
    Given this JSON:
      """
      { "person": "felizberto" }
      """
    Then the JSON should conform to this schema:
      """
      { "type": "object" }
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
