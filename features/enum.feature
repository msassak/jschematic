Feature: Core schema: enum
  Scenario: enum
    When the schema is:
      """
      {
          "enum": [1, "two", [[], [], []], { "four": 4 }]
      }
      """
    Then these are valid JSON:
      | 1             |
      | "two"         |
      | [[], [], []]  |
      | { "four": 4 } |
    But these are not valid JSON:
      | "one"                  |
      | 2                      |
      | [true, false]          |
      | { "name": "Mariposa" } |

  Scenario: empty enum
    When the schema is '{ "enum": [] }'
    Then these are not valid JSON:
      | ""   |
      | []   |
      | {}   |
      | null |
