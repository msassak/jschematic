Feature: Core schema: minLength & maxLength

  Scenario: minLength
    When the schema is '{ "minLength": 3 }'
    Then '"foo"' is valid JSON
    And '"quux"' is valid JSON
    But '"aa"' is not valid JSON
