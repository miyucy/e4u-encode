require 'e4u/encode/kddi/utf8/kddi_unicode'
class E4U::Encode::KDDI::Unicode
  UTF8 = E4U::Encode::KDDI::Utf8::KDDI_UNICODE.invert.freeze
  UTF8_REGEXP = Regexp.new("&#x((?i:#{UTF8.keys.join('|')}));").freeze
end
