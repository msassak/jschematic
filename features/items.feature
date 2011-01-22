Feature: Core schema: items, minItems & maxItems
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
    And '[]' is valid JSON
    But '["Felizberto", 2112, "Albi"]' is not valid JSON

  Scenario: tuple typing with an array of schemas
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
    And '["Felizberto", 2112, "Albi"]' is valid JSON
    But '[2112, "Felizberto"]' is not valid JSON
    And '["Felizberto", "Lil Wayne"]' is not valid JSON

  Scenario: tuple typing when additional items is false
  Scenario: tuple typing with additional items schema
  Scenario: instance JSON is not an array

  Scenario: minItems
    When the schema is '{ "minItems": 2 }'
    Then '["apple", "orange", "pear"]' is valid JSON
    And '["cucumber", "sativus"]' is valid JSON
    But '["pomegranate"]' is not valid JSON

  Scenario: maxItems
