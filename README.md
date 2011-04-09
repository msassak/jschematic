# Jschematic

Jschematic is a JSON Schema Validator for Ruby. Its aim is to validate
schemas conforming to the most recent version of the JSON Schema draft
standard, which today means v3.

Supporting older versions of the standard is not out of the question,
but it is not a primary development focus.

## Status

The core schema definition is supported with these exceptions:

 * extends

The format attribute supports only these formats:

 * date-time
 * date
 * ip-address
 * ipv6
 * uri

Adding ad-hoc support for different formats should be relatively painless.
Look in jschematic/attributes/format.rb to get started.

Please report any bugs you find in the issue tracker here:
https://github.com/msassak/jschematic/issues.

## Basic Usage

    require 'jschematic'
    Jschematic.validate(json, schema)  # => true or false
    Jschematic.validate!(json, schema) # => true or raise Jschematic::ValidationError

`json` and `schema` above must be Ruby data structures, not real JSON.

Jschematic doesn't care how you turn JSON into Ruby (though we use the
fine yajl-ruby gem for testing).

## Advanced Usage

Pass extra schemas to inform the validation context:

    Jschematic.validate(json, schema, :context => [cs1, cs2])

Each context schema will be consulted in those cases where cross-schema
referencing is allowed, e.g. $ref.

To enable debugging support, set :debug to true in the options hash:

    Jschematic.validate!(json, schema, :debug => true)

With debugging on a warning is printed when schema contain unknown
attributes.

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
