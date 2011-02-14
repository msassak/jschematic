Feature: Core schema: id
  Scenario: absolute URI, single schema
    When the schema is:
      """
      {
          "title": "Test Schema",
          "id": "http://www.example.com/schemas/json"
      }
      """
    Then the id of "Test Schema" is "http://www.example.com/schemas/json"

  Scenario: relative URI, single schema
    I-D says: "If this schema is not contained in any parent schema, the 
    current URI of the parent schema is held to be the URI under which 
    this schema was addressed."

    I think this means that the id of the root schema is taken to be the 
    URI from which the schema was retrieved, i.e. schema validators are
    supposed to include an HTTP client, which seems a bit bonkers to me,
    or the client passes in the URI from where the schema was retrieved, 
    which is weird, but more palatable. The current implementation does
    neither of these, but I don't think it's too important at this point. 
    
    When the schema is:
      """
      {
          "title": "Test Schema",
          "id": "/schemas/json"
      }
      """
    Then the id of "Test Schema" is "/schemas/json"

  Scenario: absolute URI at root, absolute in child
    When the schema is:
      """
      {
          "title": "Root Schema",
          "id": "http://www.example.com/schemas/root",
          "properties": {
              "child": {
                  "title": "Child Schema",
                  "id": "http://www.example.org/schemas/child"
              }
          }
      }
      """
    Then the id of "Root Schema" is "http://www.example.com/schemas/root"
    And the id of "Child Schema" is "http://www.example.org/schemas/child"

  Scenario: absolute URI at root, relative in child
    http://tools.ietf.org/html/rfc3986#section-5
    http://tools.ietf.org/html/rfc3986#section-3

      foo://example.com:8042/over/there?name=ferret#nose
       \_/   \______________/\_________/ \_________/ \__/
        |           |            |            |        |
     scheme     authority       path        query   fragment

     5.4

       Within a representation with a well defined base URI of

          http://a/b/c/d;p?q

       a relative reference is transformed to its target URI as follows.

     5.4.1.  Normal Examples

        "g:h"           =  "g:h"
        "g"             =  "http://a/b/c/g"
        "./g"           =  "http://a/b/c/g"
        "g/"            =  "http://a/b/c/g/"
        "/g"            =  "http://a/g"
        "//g"           =  "http://g"
        "?y"            =  "http://a/b/c/d;p?y"
        "g?y"           =  "http://a/b/c/g?y"
        "#s"            =  "http://a/b/c/d;p?q#s"
        "g#s"           =  "http://a/b/c/g#s"
        "g?y#s"         =  "http://a/b/c/g?y#s"
        ";x"            =  "http://a/b/c/;x"
        "g;x"           =  "http://a/b/c/g;x"
        "g;x?y#s"       =  "http://a/b/c/g;x?y#s"
        ""              =  "http://a/b/c/d;p?q"
        "."             =  "http://a/b/c/"
        "./"            =  "http://a/b/c/"
        ".."            =  "http://a/b/"
        "../"           =  "http://a/b/"
        "../g"          =  "http://a/b/g"
        "../.."         =  "http://a/"
        "../../"        =  "http://a/"
        "../../g"       =  "http://a/g"


    When the schema is:
      """
      {
          "title": "Root Schema",
          "id": "http://www.example.com/schemas/root/",
          "properties": {
              "relchild": {
                  "title": "Relative Path Child Schema",
                  "id": "child"
              },
              "fragchild": {
                  "title": "Fragment Child Schema",
                  "id": "#child"
              },
              "abspathchild": {
                  "title": "Absolute Path Child Schema",
                  "id": "/child"
              }
          }
      }
      """
    Then the id of "Root Schema" is "http://www.example.com/schemas/root/"
    And the id of "Fragment Child Schema" is "http://www.example.com/schemas/root/#child"
    And the id of "Absolute Path Child Schema" is "http://www.example.com/child"
    And the id of "Relative Path Child Schema" is "http://www.example.com/schemas/root/child"

  Scenario: absolute URI in branch or leaf
  Scenario: relative URI in branch or leaf
