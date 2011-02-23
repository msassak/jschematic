Feature: Core Schema: properties & additionalProperties

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

  Scenario: additionalProperties is false
    When the schema is:
      """
      {
          "properties": {
              "name": { "type": "string" },
              "age": { "type": "integer" }
          }, 

          "additionalProperties": false
      }
      """
    Then this is valid JSON:
      """
      {
          "name": "Felizberto Albi",
          "age": 24
      }
      """
    But this is not valid JSON:
      """
      {
          "name": "Felizberto Albi",
          "age": 24,
          "color": "red"
      }
      """

  Scenario: additionalProperties defined by a schema
    When the schema is:
      """
      {
          "properties": {
              "name": { "type": "string" },
              "age": { "type": "integer" }
          },

          "additionalProperties": {
              "type": "string"
          }
      }
      """
    Then this is valid JSON:
      """
      {
          "name": "Felizberto Albi",
          "age": 24,
          "color": "red"
      }
      """
    But this is not valid JSON:
      """
      {
          "name": "Felizberto Albi",
          "age": 24,
          "number": 2112
      }
      """

  Scenario: when true
    TODO: duh
  Scenario: neither boolean nor schema
    TODO: should fail loudly: move into spec
  Scenario: empty instance
    TODO: find out what the behavior here should be
