Feature: Core schema: minLength & maxLength

  Scenario: minLength
    When the schema is '{ "minLength": 3 }'
    Then '"foo"' is valid JSON
    And '"quux"' is valid JSON
    But '"aa"' is not valid JSON

  Scenario: maxLength
    When the schema is '{ "maxLength": 3 }'
    Then '"aa"' is valid JSON
    And '"foo"' is valid JSON
    But '"quux"' is not valid JSON

  Scenario: together
    When the schema is '{ "minLength": 1, "maxLength": 2 }'
    Then '"a"' is valid JSON
    And '"aa"' is valid JSON
    But '"aaa"' is not valid JSON
    And '""' is not valid JSON
