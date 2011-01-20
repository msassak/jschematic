Feature: Core schema: patternProperties

  Scenario: one pattern
    When the schema is:
      """
      {
          "patternProperties": {
              "[Nn]ame$": { "type": "string" }
          }
      }
      """
    Then these are valid JSON:
      | { "name": "Felizberto" }        |
      | { "firstName": "Fitzheraldo" }  |
      | { "fullName": "Inigo Montoya" } |
    But these are not valid JSON:
      | { "name": 2112 }      |
      | { "named": "Werner" } | 
