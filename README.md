# Jschematic

Jschematic is a JSON Schema v3 Validator for Ruby.

It is currently incomplete, alpha quality software.

Having said that, most of the core schema definition is supported
with these exceptions:

 * $ref
 * $schema
 * extends
 * divisibleBy
 * disallow

In addition to this, only IPv4, IPv6 and URI formats are currently
implemented.

Please report any bugs you find (and you will find bugs) at the issue
tracker here: https://github.com/msassak/jschematic/issues.

## Basic Usage

    require 'jschematic'
    Jschematic.validate(json, schema)  # => true or false
    Jschematic.validate!(json, schema) # => true or raise Jschematic::ValidationError

`json` and `schema` above must be Ruby data structures, not real JSON.

Jschematic doesn't care how you turn JSON into Ruby (though we use the
fine yajl-ruby gem for testing).

## Advanced Usage

See ...

## Testing

    $ cucumber
    $ rspec spec

Or `rake` if you want to run both.

## Links

* http://tools.ietf.org/html/draft-zyp-json-schema-03
* https://github.com/kriszyp/json-schema
* http://tools.ietf.org/html/rfc3986
* https://groups.google.com/d/topic/json-schema/lftABvH5KkA/discussion

## Copyright

Copyright (c) 2011 Mike Sassak. See LICENSE for details.
