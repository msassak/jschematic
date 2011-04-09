Feature: Core schema: disallow

  Scenario: simple type
    When the schema is:
      """
      {
          "disallow": "integer"
      }
      """
    Then these are valid JSON:
      | "oh hai" |
      | 3.14159  |
      | [1,2,3]  |
    But '42' is not valid JSON

  Scenario: complex type
    When the schema is:
      """
      {
          "disallow": [
              "string",
              { "type": "float" }
          ]
      }
      """
    Then these are valid JSON:
      | 42               |
      | [1,2,3,4]        |
      | { "foo": "bar" } |
    But these are not valid JSON:
      | "hi how are you?" |
      | 3.14159           |

