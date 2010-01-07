require 'e4u/encode/docomo/utf8/docomo_unicode'
class E4U::Encode::DoCoMo::Unicode
  UTF8 = E4U::Encode::DoCoMo::Utf8::DOCOMO_UNICODE.invert.freeze
  UTF8_REGEXP = Regexp.new("&#x((?i:#{UTF8.keys.join('|')}));").freeze
end
