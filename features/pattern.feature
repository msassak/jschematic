Feature: Core schema: pattern
  Scenario: pattern
    When the schema is '{ "pattern": "^wibble$" }'
    Then '"wibble"' is valid JSON
    But '"rewibble"' is not valid JSON
    And '"wibbler"' is not valid JSON
