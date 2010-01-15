module E4U
  module Encode
    module Ketai
      autoload :Unicode, 'e4u/encode/ketai/unicode'

      def self.encode str, from, to
        raise unless from[:carrier] == :ketai
        if to[:carrier] == :ketai
          encode_carrier(str, from, to)
        else
          encode_encoding(str, from, to)
        end
      end

      private

      def self.encode_carrier str, from, to
        return encode_encoding(str, from, to) if from[:encoding] != :unicode
        case to[:encoding]
        when :sjis
          from[:encoding] = :sjis
          Encoding.to_cp932(str)
        when :utf8
          from[:encoding] = :utf8
          str
        else
          raise
        end
      end

      def self.encode_encoding str, from, to
        case from[:encoding]
        when :sjis
          from[:encoding] = :unicode
          Encoding.to_utf8(str)
        when :utf8
          from[:encoding] = :unicode
          str
        when :unicode
          from[:carrier] = :google
          Unicode.to_google_unicode(str)
        else
          raise
        end
      end
    end
  end
end
