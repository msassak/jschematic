Feature: Core schema: $ref
  Scenario: Ref resolves to the same schema
    When the schema is:
      """
      {
          "id": "http://www.example.com/schemas/person",
          "title": "The Best Person Schema Ever",
          "properties": {
              "name": { "type": "string" },
              "age": { "type": "integer" },
              "favorite_person": { "$ref": "http://www.example.com/schemas/person" }
          }
      }
      """
    Then this is valid JSON:
      """
      {
          "name": "Felizberto Albi",
          "age": 24,
          "favorite_person": {
              "name": "Lil Wayne Pangles",
              "age": 52,
              "favorite_person": {
                  "name": "Birdman Pangles",
                  "age": 71,
                  "favorite_person": {
                      "name": "Best here to be silent",
                      "age": 105
                  }
              }
          }
      }
      """
    But this is not valid JSON:
      """
      {
          "name": "Felizberto Albi",
          "age": 24,
          "favorite_person": {
              "name": "Lil Wayne Pangles",
              "age": "At least a billion. At least."
          }
      }
      """

  Scenario: Ref with relative path resolves to the same schema

  Scenario: Ref resolves to different schema
    Given the schema:
      """
      """
    And this schema:
      """
      """
    Then this is valid JSON:
      """
      """
    But this is not valid JSON:
      """
      """

  Scenario: Ref appears before the id it references
