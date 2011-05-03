Feature: Core schema: extends

  Scenario: extending a single schema by ID
    Given the validation context contains this schema:
      """
      {
          "id": "person",
          "properties": {
              "name": {
                  "type": "string",
                  "required": true
              }
          }
      }
      """
    When the schema is:
      """
      {
          "properties": {
              "age": {
                  "type": "integer",
                  "required": true
              }
          },
          "extends": "person"
      }
      """
    Then this is valid JSON:
      """
      {
          "name": "Felizberto Albi Perez Fernandez Mariposa Carlos Velasquez",
          "age": 24
      }
      """
    But this is not valid JSON:
      """
      {
          "age": 24
      }
      """

  Scenario: extending a literal schema
    When the schema is:
      """
      {
          "properties": {
              "age": {
                  "type": "integer",
                  "required": true
              }
          },

          "extends": {
              "properties": {
                  "name": {
                      "type": "string",
                      "required": true
                  }
              }
          }
      }
      """
    Then this is valid JSON:
      """
      {
          "name": "Felizberto Albi Perez Fernandez Mariposa Carlos Velasquez",
          "age": 24
      }
      """
    But this is not valid JSON:
      """
      {
          "age": 24
      }
      """

  Scenario: extending multiple schemas
