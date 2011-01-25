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

  Scenario: default for all types
    TODO: spec
