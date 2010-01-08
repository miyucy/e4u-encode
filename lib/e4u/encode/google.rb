module E4U
  module Encode
    module Google
      autoload :Utf8,    'e4u/encode/google/utf8'
      autoload :Unicode, 'e4u/encode/google/unicode'

      def self.encode str, from, to
        raise unless from[:carrier] == :google
        case from[:encoding]
        when :utf8
          from[:encoding] = :unicode
          Utf8.to_google_unicode(str)
        when :unicode
          encode_carrier str, from, to
        else
          raise
        end
      end

      private

      def self.encode_carrier str, from, to
        case to[:carrier]
        when :docomo
          from[:carrier] = :docomo
          Unicode.to_docomo_unicode(str)
        when :kddi
          from[:carrier] = :kddi
          Unicode.to_kddi_unicode(str)
        when :softbank
          from[:carrier] = :softbank
          Unicode.to_softbank_unicode(str)
        when :google
          if to[:encoding] == :utf8
            from[:encoding] = :utf8
            Unicode.to_utf8(str)
          else
            raise
          end
        else
          raise
        end
      end

    end
  end
end
