class E4U::Encode::KDDI::Cp932
  %w(KDDI_UNICODE KDDI_UNICODE_REGEXP).each do |konst|
    autoload konst, 'e4u/encode/kddi/cp932/kddi_unicode'
  end

  def self.to_kddi_unicode str
    puts "kddi_cp932_to_kddi_unicode" if $DEBUG
    str.gsub(KDDI_UNICODE_REGEXP) do |matched|
      "&#x#{KDDI_UNICODE[matched]};"
    end
  end
end
