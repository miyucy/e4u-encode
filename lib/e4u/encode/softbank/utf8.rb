class E4U::Encode::Softbank::Utf8
  %w(SOFTBANK_UNICODE SOFTBANK_UNICODE_REGEXP).each do |konst|
    autoload konst, 'e4u/encode/softbank/utf8/softbank_unicode'
  end

  def self.to_softbank_unicode str
    puts "softbank_utf8_to_softbank_unicode" if $DEBUG
    str.gsub(SOFTBANK_UNICODE_REGEXP) do |matched|
      "&#x#{SOFTBANK_UNICODE[matched]};"
    end
  end
end
