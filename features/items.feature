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

  Scenario: tuple typing with an array of schemas
    TODO: currently it allows additional items--not sure if that
    is the correct behavior according to the standard
    ---
    When the schema is:
      """
      {
          "items": [
              { "type": "string" },
              { "type": "integer" }
          ]
      }
      """
    Then '["Felizberto", 2112]' is valid JSON
    But '[2112, "Felizberto"]' is not valid JSON
    And '["Felizberto", "Lil Wayne"]' is not valid JSON

  Scenario: tuple typing with additional items
  Scenario: instance JSON is not an array
              
