Feature: Core Schema: properties

  Scenario: instance property values must conform to schema property definitions
    When the schema is:
      """
      {
          "properties": {
              "name": { "type": "string" }
          }
      }
      """
    Then '{ "name": "Felizberto" }' is valid JSON
    And '{ "color": "red" }' is valid JSON
    But '{ "name": 12345" }' is not valid JSON

  Scenario: With extra attribute
    When the schema is:
      """
      {
          "properties": {
              "age": { "maximum": 25 }
          }
      }
      """
    Then '{ "age": 25, "color": "red" }' is valid JSON
    But '{ "age": 26, "color": "red" }' is not valid JSON

  Scenario: deeply nested
    When the schema is:
      """
      {
          "properties": {
              "attributes": { 
                  "properties": {
                      "attribute": { 
                          "type": "string" 
                      }
                  }
              }
          }
      }
      """
    Then this is valid JSON:
      """
      {
          "attributes": {
              "attribute": "value"
          }
      }
      """
    But this is not valid JSON:
      """
      {
          "attributes": {
              "attribute": 2112
          }
      }
      """

  Scenario: empty instance
    TODO: find out what the behavior here should be

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

