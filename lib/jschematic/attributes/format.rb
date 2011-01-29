require 'uri'

module Jschematic
  module Attributes
    module Format
      def self.new(format)
        case format
        when "uri"
          Uri.new
        else
          puts "Don't recognize #{format}"
        end
      end

      class Uri
        def accepts?(uri)
          URI.parse(uri)
        rescue URI::InvalidURIError
          false
        end
      end
    end
  end
end
