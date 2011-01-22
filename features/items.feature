Feature: Core schema: items, additionalItems, minItems, maxItems & uniqueItems
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
    When the schema is:
      """
      {
          "items": [ { "type": "string" } ],
          "additionalItems": false 
      }
      """
    Then '["Feliberto"]' is valid JSON
    But '["Felizberto", "Albi"]' is not valid JSON

  Scenario: tuple typing with additional items schema
    When the schema is:
      """
      {
          "items": [ { "type": "string" } ],
          "additionalItems": { "type": "object" }
      }
      """
    Then '["Albi", { "age": 24 }]' is valid JSON
    But '["Albi", 24]' is not valid JSON

  Scenario: instance JSON is not an array

  Scenario: minItems
    When the schema is '{ "minItems": 2 }'
    Then '["apple", "orange", "pear"]' is valid JSON
    And '["cucumber", "sativus"]' is valid JSON
    But '["pomegranate"]' is not valid JSON

  Scenario: maxItems
    When the schema is '{ "maxItems": 2 }'
    Then '["pomegranate"]' is valid JSON
    And '["cucumber", "sativus"]' is valid JSON
    But '["apple", "orange", "pear"]' is not valid JSON

  Scenario: min and max together
    When the schema is:
      """
      {
          "minItems": 1,
          "maxItems": 2
      }
      """
    Then '["pomegranate"]' is valid JSON
    And  '["cucumber", "sativus"]' is valid JSON
    But '["apple", "orange", "pear"]' is not valid JSON
    And '[]' is not valid JSON

  Scenario: uniqueItems
    When the schema is '{ "uniqueItems": true }'
    Then these are valid JSON:
      | [1,2]                    |
      | ["a", "b"]               |
      | [true, false]            |
      | [{"foo": 1}, {"foo": 2}] |
    But these are not valid JSON:
      | [1,1]                    |
      | ["a", "a"]               |
      | [true, true]             |
      | [{"foo": 1}, {"foo": 1}] |
