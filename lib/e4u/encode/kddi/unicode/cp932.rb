require 'e4u/encode/kddi/cp932/kddi_unicode'
class E4U::Encode::KDDI::Unicode
  CP932 = E4U::Encode::KDDI::Cp932::KDDI_UNICODE.invert.freeze
  CP932_REGEXP = Regexp.new("&#x((?i:#{CP932.keys.join('|')}));").freeze
end
