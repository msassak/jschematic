@sanity-check
Feature: Core Schema: minimum, maximum & related

  Scenario: minimum
    When the schema is:
      """
      { "minimum": 25 }
      """
    Then '26.1' is valid JSON
    And '25' is valid JSON
    But '24' is not valid JSON

  Scenario: instance value is not a number
    TODO: this should be a spec, and tested for maximum as well
    ---
    When the schema is:
      """
      { "minimum": 24 }
      """
    Then '"portokalli"' is valid JSON

  Scenario: exclusiveMinimum
    TODO: test dependency on minimum in spec
    ---
    When the schema is:
      """
      { "minimum": 25, "exclusiveMinimum": true }
      """
    Then '26' is valid JSON
    But '25' is not valid JSON

  Scenario: maximum
    When the schema is:
      """
      { "maximum": 25 }
      """
    Then '25' is valid JSON
    And '24' is valid JSON
    But '26' is not valid JSON

  Scenario: exclusiveMaximum
    TODO: test dependency on maximum in spec
    ---
    When the schema is:
      """
      { "maximum": 25, "exclusiveMaximum": true }
      """
      Then '24.9' is valid JSON
      But '25' is not valid JSON
