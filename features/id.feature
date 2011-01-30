Feature: Core schema: id
  Scenario: absolute URI, single schema
    When the schema is:
      """
      {
          "title": "Test Schema",
          "id": "http://www.example.com/schemas/json"
      }
      """
    Then the id of "Test Schema" is "http://www.example.com/schemas/json"

  Scenario: relative URI, single schema
  Scenario: absolute URI at root
  Scenario: relative URI at root
  Scenario: absolute URI in branch or leaf
  Scenario: relative URI in branch or leaf
