Feature: Core schema: dependencies
  Scenario: depending on a single property name
    When the schema is:
      """
      {
          "dependencies": { "foo": "bar" }
      }
      """
    Then this is valid JSON:
      """
      {
          "foo": "baz",
          "bar": "qux"
      }
      """
    But this is not valid JSON:
      """
      {
          "foo": "baz",
          "wibble": "womble"
      }
      """

  Scenario: depending on each item in list of property names
    When the schema is:
      """
      {
          "dependencies": { "foo": ["bar", "baz"] }
      }
      """
    Then this is valid JSON:
      """
      {
          "foo": "qux",
          "bar": "quux",
          "baz": "wibble"
      }
      """
    But this is not valid JSON:
      """
      {
          "foo": "qux",
          "bar": "quux"
      }
      """
      
  Scenario: depend on schema
    When the schema is:
      """
      {
          "dependencies": {
              "foo": {
                  "properties": {
                      "favoriteNumber": { "type": "number" }
                  }
              }
          }
      }
      """
    Then this is valid JSON:
      """
      {
          "foo": "bar",
          "favoriteNumber": 3.1415
      }
      """
    But this is not valid JSON:
      """
      {
          "foo": "bar",
          "favoriteNumber": "eleventy million"
      }
      """
