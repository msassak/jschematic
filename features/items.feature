Feature: Core schema: items
  Scenario: single schema
    When the schema is:
      """
      {
          "items": {
              "type": "string"
          }
      }
      """
    Then '["Felizberto", "Lil Wayne", "Albi"]' is valid JSON
    But '["Felizberto", 2112, "Albi"]' is not valid JSON

  Scenario: array of schemas
