Feature: Core schema: required
  Scenario: default false 
    When the schema is:
      """
      {
          "properties": {
              "color": { 
                  "type": "string"
              }
          }
      }
      """
    Then '{}' is valid JSON

    When the schema is:
      """
      {
          "properties": {
              "color": {
                  "type": "string",
                  "required": false
              }
          }
      }
      """
    Then '{}' is valid JSON

  Scenario: true
    When the schema is:
      """
      {
          "properties": {
              "color": {
                  "type": "string",
                  "required": true
              }
          }
      }
      """
    Then '{ "color": "red" }' is valid JSON
    But '{}' is not valid JSON
    And '{ "age": 24 }' is not valid JSON

  Scenario: anything else
    TODO: the draft standard is silent about what
    happens when required is not false. I favor
    making it evaluate to true, but this is another
    question for the ML. 
