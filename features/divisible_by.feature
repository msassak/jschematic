Feature: Core schema: divisibleBy
  Scenario: No remainder
    Given the schema is:
      """
      {
          "divisibleBy": 2
      }
      """
    Then these are valid JSON:
      | 0    |
      | 2    |
      | 42.0 |
    But these are not valid JSON:
      | 0.1  |
      | 1    |
      | 13   |

