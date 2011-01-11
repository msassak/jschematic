Feature: Schema Properties
  Scenario: With type attribute
    When the schema is:
      """
      {
          "properties": {
              "name": { "type": "string" }
          }
      }
      """
      Then '{ "name": "Felizberto" }' is valid JSON
      But '{ "name": 12345" }' is not valid JSON

  Scenario: With maximum attribute
    When the schema is:
      """
      {
          "properties": {
              "age": { "maximum": 25 }
          }
      }
      """
      Then '{ "age": 25 }' is valid JSON
      But '{ "age": 26 }' is not valid JSON

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
