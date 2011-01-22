Feature: Core Schema: minimum, exclusiveMinimum, maximum & exclusiveMaximum

  Scenario: minimum
    When the schema is '{ "minimum": 25 }'
    Then '26.1' is valid JSON
    And '25' is valid JSON
    But '24' is not valid JSON

  Scenario: exclusiveMinimum
    When the schema is:
      """
      { "minimum": 25, "exclusiveMinimum": true }
      """
    Then '26' is valid JSON
    But '25' is not valid JSON

  Scenario: maximum
    When the schema is '{ "maximum": 25 }'
    Then '25' is valid JSON
    And '24.9' is valid JSON
    But '25.1' is not valid JSON

  Scenario: exclusiveMaximum
    When the schema is:
      """
      { "maximum": 25, "exclusiveMaximum": true }
      """
    Then '24.9' is valid JSON
    But '25' is not valid JSON
