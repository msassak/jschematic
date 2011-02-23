Feature: Core schema: default

  Scenario: validation succeeds because of default
    When the schema is:
      """
      {
          "properties": {
              "name": {
                  "type": "string",
                  "required": true
              }
          },

          "default": {
              "name": "Gristle Thornbody"
          }
      }
      """
      Then '{ "age": 35 }' is valid JSON

  Scenario: validation fails because of default
    When the schema is:
      """
      {
          "properties": {
              "name": {
                  "type": "string"
              }
          },

          "default": {
              "name": 1999
          }
      }
      """
    Then '{ "age": 35 }' is not valid JSON

  Scenario: validation of property succeeds because of default
    When the schema is:
      """
      {
          "properties": {
              "pi": {
                  "type": "number",
                  "required": true,
                  "default": 3.1415
              }
          }
      }
      """
    Then '{ "somethingElse": "foo" }' is valid JSON
    But '{ "pi": "is delicious" }' is not valid JSON

  Scenario: validation of property fails because of default
    When the schema is:
      """
      {
          "properties": {
              "pi": {
                  "type": "number",
                  "required": true,
                  "default": "is delicious"
              }
          }
      }
      """
    Then '{ "somethingElse": "foo" }' is not valid JSON
    But '{ "pi": 3.1415 }' is valid JSON

  Scenario: default for all types
    TODO: spec
