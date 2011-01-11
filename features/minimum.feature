@sanity-check
Feature: Core Schema: minimum

  Scenario: minimum
    When the schema is:
      """
      { "minimum": 25 }
      """
    Then '26.1' is valid JSON
    And '25' is valid JSON
    But '24' is not valid JSON

  Scenario: instance value is not a number
    When the schema is:
      """
      { "minimum": 24 }
      """
    Then '"portokalli"' is valid JSON

  Scenario: exclusiveMinimum
    When the schema is:
      """
      { "minimum": 25, "exclusiveMinimum": true }
      """
    Then '26' is valid JSON
    But '25' is not valid JSON
