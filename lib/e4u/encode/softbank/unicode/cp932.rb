require 'e4u/encode/softbank/cp932/softbank_unicode'
class E4U::Encode::Softbank::Unicode
  CP932 = E4U::Encode::Softbank::Cp932::SOFTBANK_UNICODE.invert.freeze
  CP932_REGEXP = Regexp.new("&#x((?i:#{CP932.keys.join('|')}));").freeze
end
