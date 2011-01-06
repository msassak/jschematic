Feature: Schema Properties
  Scenario: With string property
    When the schema is:
      """
      {
          "type": "object",
          "properties": {
              "name": { "type": "string" }
          }
      }
      """
    Then this should be acceptable JSON:
      """
      { "name": "Felizberto" }
      """
