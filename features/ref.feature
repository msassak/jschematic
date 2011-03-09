Feature: Core schema: $ref
  Scenario: Ref resolves to the same schema
    When the schema is:
      """
      {
          "id": "person",
          "title": "The Best Person Schema Ever",
          "properties": {
              "name": { "type": "string" },
              "age": { "type": "integer" },
              "favorite_person": { "$ref": "person" }
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
              "age": 9000
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
  Scenario: Ref resolution fails
  Scenario: Ref resolves to different schema
