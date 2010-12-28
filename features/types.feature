Feature: Schema Types
  Scenario: string
    Given this JSON:
      """
      { "announcement": "hello, world" }
      """
    Then the JSON should conform to this schema:
      """
      { "type": "string" }
      """
