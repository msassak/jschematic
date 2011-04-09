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

  Scenario: IPv4 CIDR
    When the schema is:
      """
      {
          "type": "string",
          "format": "cidr"
      }
      """
    Then '"192.168.0.1/23"' is valid JSON
    But these are not valid JSON:
      | ""            |
      | "192.168.0.1" |
      | "6.7.8.9/0"   |
      | "1.2.3.4/33"  |

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

  Scenario: Date-Time
    When the schema is:
      """
      {
          "type": "string",
          "format": "date-time"
      }
      """
    Then these are valid JSON:
      | "1999-12-31T23:59:59Z" |
      | "2011-02-27T10:12:13Z" |
      | "1980-02-29T08:51:32Z" |
    But these are not valid JSON:
      | "1999-12-31"           |
      | "1981-02-29T01:01:01Z" |
      | "August 1st, 1986"     |

  Scenario: Date
    When the schema is:
      """
      {
          "type": "string",
          "format": "date"
      }
      """
    Then these are valid JSON:
      | "1999-12-31" |
      | "2011-02-27" |
      | "1980-02-29" |
    But these are not valid JSON:
      | "1981-02-29"           |
      | "August 1st, 1986"     |
      | "1980-02-29T08:51:32Z" |

