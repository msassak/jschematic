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

  Scenario: IPv4
    When the schema is:
      """
      {
          "type": "string",
          "format": "ip-address"
      }
      """
    Then '"127.0.0.1"' is valid JSON
    But these are not valid JSON:
      | ""                         |
      | "fe80::202:b3ff:fe1e:8329" |

  Scenario: IPv6
    When the schema is:
      """
      {
          "type": "string",
          "format": "ipv6"
      }
      """
    Then these are valid JSON:
      | "2001:0db8:85a3:0000:0000:8a2e:0370:7334" |
      | "fe80:0:0:0:202:b3ff:fe1e:8329"           |
      | "fe80::202:b3ff:fe1e:8329"                |
    But these are not valid JSON:
      | ""          |
      | "127.0.0.1" |
