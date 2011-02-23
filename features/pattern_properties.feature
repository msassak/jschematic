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
      | { "doesNotMatch": 12345678 }    |
    But these are not valid JSON:
      | { "name": 2112 }         |
      | { "aNiceName": [1,2,3] } |

  Scenario: multiple patterns
    When the schema is:
      """
      {
          "patternProperties": {
              "^foos": { "type": "string" },
              "umber$": { "type": "integer" }
          }
      }
      """
    Then these are valid JSON:
      | { "foosball": "is a silly game" } |
      | { "number": 2112 }                |
    But these are not valid JSON:
      | { "humber": "Fourty-two" }        |
      | { "foos": 2112 }                  |

  Scenario: pattern with vanilla property
    When the schema is:
      """
      {
          "properties": {
              "a": { "type": "string" }
          },

          "patternProperties": {
              "a": { "enum": ["fnord", 42] }
          }
      }
      """
    Then this is valid JSON:
      """
      {
          "a": "fnord",
          "apple": 42,
          "aardvark": "fnord"
      }
      """
    But these are not valid JSON:
      | { "a": 42 }          |
      | { "apple": "6 * 9" } |
      | { "aardvark": 41 }   |
