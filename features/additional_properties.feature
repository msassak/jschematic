Feature: Core schema: additionalProperties
  Scenario: when false
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

  Scenario: when a schema 
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

  Scenario: neither false nor schema
    TODO: should fail loudly: move into spec
