class E4U::Encode::DoCoMo::Cp932
  %w(DOCOMO_UNICODE DOCOMO_UNICODE_REGEXP).each do |konst|
    autoload konst, 'e4u/encode/docomo/cp932/docomo_unicode'
  end

  def self.to_docomo_unicode str
    puts "docomo_cp932_to_docomo_unicode" if $DEBUG
    str.gsub(DOCOMO_UNICODE_REGEXP) do |matched|
      "&#x#{DOCOMO_UNICODE[matched]};"
    end
  end
end
