require 'ipaddr'
require 'addressable/uri'
require 'date'

module Jschematic
  module Attributes
    module Format
      def self.new(format)
        format_class = format.split(/[^\w\d]/).inject("") do |name, part|
          name << part.capitalize
        end

        const_get(format_class).new
      rescue NameError
        NullFormat.new(format)
      end

      class Uri
        include Jschematic::Element

        def accepts?(uri)
          Addressable::URI.parse(uri)
        rescue Addressable::URI::InvalidURIError
          false
        end
      end

      class IpAddress
        include Jschematic::Element

        def accepts?(addr)
          IPAddr.new(addr).ipv4?
        rescue ArgumentError
          false
        end
      end

      class Ipv6
        include Jschematic::Element

        def accepts?(addr)
          IPAddr.new(addr).ipv6?
        rescue ArgumentError
          false
        end
      end

      class Cidr
        include Jschematic::Element

        def accepts?(addr_with_cidr)
          addr, cidr = addr_with_cidr.split("/")
          return false unless cidr && (1..32).include?(cidr.to_i)
          IpAddress.new.accepts?(addr)
        end
      end

      class DateTime
        include Jschematic::Element

        def accepts?(date_time)
          ::DateTime.strptime(date_time)
        rescue ArgumentError
          false
        end
      end

      class Date
        include Jschematic::Element

        def accepts?(date)
          raise ArgumentError unless date =~ /^\d{4}-\d{2}-\d{2}$/
          ::Date.strptime(date)
        rescue ArgumentError
          false
        end
      end

      class NullFormat
        include Jschematic::Element
        attr_reader :format

        def initialize(format)
          @format = format
        end

        def accepts?(instance)
          true
        end
      end
    end
  end
end
