Feature: Core schema: id

  See: https://groups.google.com/d/msg/json-schema/lftABvH5KkA/KW93ZX-JdpsJ
  for an explanation. The relevant part is "URIs, not URLs", i.e. id attributes
  are for *identifying* schemas, not for *locating* them. No retrieval is
  necessary.

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
    When the schema is:
      """
      {
          "title": "Test Schema",
          "id": "/schemas/json"
      }
      """
    Then the id of "Test Schema" is "/schemas/json"

  Scenario: absolute URI at root, absolute in child
    When the schema is:
      """
      {
          "title": "Root Schema",
          "id": "http://www.example.com/schemas/root",
          "properties": {
              "child": {
                  "title": "Child Schema",
                  "id": "http://www.example.org/schemas/child"
              }
          }
      }
      """
    Then the id of "Root Schema" is "http://www.example.com/schemas/root"
    And the id of "Child Schema" is "http://www.example.org/schemas/child"

  Scenario: absolute URI at root, relative in child
    When the schema is:
      """
      {
          "title": "Root Schema",
          "id": "http://www.example.com/schemas/root/",
          "properties": {
              "relchild": {
                  "title": "Relative Path Child Schema",
                  "id": "child"
              },
              "fragchild": {
                  "title": "Fragment Child Schema",
                  "id": "#child"
              },
              "abspathchild": {
                  "title": "Absolute Path Child Schema",
                  "id": "/child"
              }
          }
      }
      """
    Then the id of "Root Schema" is "http://www.example.com/schemas/root/"
    And the id of "Fragment Child Schema" is "http://www.example.com/schemas/root/#child"
    And the id of "Absolute Path Child Schema" is "http://www.example.com/child"
    And the id of "Relative Path Child Schema" is "http://www.example.com/schemas/root/child"
