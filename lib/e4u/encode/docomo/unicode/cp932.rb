require 'e4u/encode/docomo/cp932/docomo_unicode'
class E4U::Encode::DoCoMo::Unicode
  CP932 = E4U::Encode::DoCoMo::Cp932::DOCOMO_UNICODE.invert.freeze
  CP932_REGEXP = Regexp.new("&#x((?i:#{CP932.keys.join('|')}));").freeze
end
