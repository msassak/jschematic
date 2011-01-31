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
    I-D says: "If this schema is not contained in any parent schema, the 
    current URI of the parent schema is held to be the URI under which 
    this schema was addressed."

    I think this means that the id of the root schema is taken to be the 
    URI from which the schema was retrieved, i.e. schema validators are
    supposed to include an HTTP client, which seems a bit bonkers to me,
    or the client passes in the URI from where the schema was retrieved, 
    which is weird, but more palatable. 
    
    When the schema is:
      """
      {
          "title": "Test Schema",
          "id": "/schemas/json"
      }
      """
    Then the id of "Test Schema" is "/schemas/json"

  Scenario: absolute URI at root
  Scenario: relative URI at root
  Scenario: absolute URI in branch or leaf
  Scenario: relative URI in branch or leaf