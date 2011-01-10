Feature: Schema Properties
  Scenario: With string property
    TODO: the "type" attribute should be unnecessary, but
    is there for the moment to please the fake implementation
    we have in the steps.
    ---
    When the schema is:
      """
      {
          "type": "object", // <-- remove me
          "properties": {
              "name": { "type": "string" }
          }
      }
      """
      Then '{ "name": "Felizberto" }' is acceptable JSON
      But '{ "name": 12345" }' is not acceptable JSON

  Scenario: possible useful syntax
    Given the schema is:
      """
      {
          "properties": {
              "name": { "type": "string" }
          }
      }
      """
    And there is a JSON object with a "name" property
    When the value of name is "Felizberto"
    Then the JSON is valid
    When the value of name is "12345"
    Then the JSON is not valid
