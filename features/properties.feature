Feature: Schema Properties
  Scenario: With string property
    When the schema is:
      """
      {
          "properties": {
              "name": { "type": "string" }
          }
      }
      """
      Then '{ "name": "Felizberto" }' is acceptable JSON
      But '{ "name": 12345" }' is not acceptable JSON

  @ignore
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
