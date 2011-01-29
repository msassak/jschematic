Feature: Core schema: format
  Scenario: URI
    When the schema is:
      """
      {
          "type": "string",
          "format": "uri"
      }
      """
    Then '"http://www.google.com"' is valid JSON
    But '"http://"' is not valid JSON
