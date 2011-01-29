require 'ipaddr'
require 'uri'

module Jschematic
  module Attributes
    module Format
      def self.new(format)
        case format
        when "uri"
          Uri.new
        when "ip-address", "ipv6"
          Ip.new(format)
        else
          NullFormat.new
        end
      end

      class Uri
        def accepts?(uri)
          URI.parse(uri)
        rescue URI::InvalidURIError
          false
        end
      end

      class Ip
        def initialize(version)
          @method = case version
          when "ip-address"
            :ipv4?
          when "ipv6"
            :ipv6?
          end
        end

        def accepts?(addr)
          IPAddr.new(addr).send(@method)
        rescue ArgumentError
          false
        end
      end

      class NullFormat
        def accepts?(instance)
          true
        end
      end
    end
  end
end
