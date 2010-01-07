require 'e4u/encode/google/utf8/unicode'
class E4U::Encode::Google::Unicode
  UTF8 = E4U::Encode::Google::Utf8::UNICODE.invert.freeze
  UTF8_REGEXP = Regexp.new("&#x((?i:#{UTF8.keys.join('|')}));").freeze
end
