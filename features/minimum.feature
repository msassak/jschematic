@sanity-check
Feature: Core Schema: minimum

  Scenario: minimum
    When the schema is:
      """
      { "minimum": 25 }
      """
    Then '26' is valid JSON
    And '25' is valid JSON
    But '24' is not valid JSON
