Feature: Schema Properties
  Scenario: With string property
    TODO: the "type" attribute should be unnecessary, but
    is there for the moment to please the fake implementation
    we have in the steps.
    ---
    When the schema is:
      """
      {
          "type": "object", // <-- remove me
          "properties": {
              "name": { "type": "string" }
          }
      }
      """
    Then this should be acceptable JSON:
      """
      { "name": "Felizberto" }
      """
