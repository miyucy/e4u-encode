require 'e4u/encode/softbank/utf8/softbank_unicode'
class E4U::Encode::Softbank::Unicode
  UTF8 = E4U::Encode::Softbank::Utf8::SOFTBANK_UNICODE.invert.freeze
  UTF8_REGEXP = Regexp.new("&#x((?i:#{UTF8.keys.join('|')}));").freeze
end
