class E4U::Encode::Google::Utf8
  %w(UNICODE UNICODE_REGEXP).each do |konst|
    autoload konst, 'e4u/encode/google/utf8/unicode'
  end

  def self.to_google_unicode str
    puts "goolge_utf8_to_google_unicode" if $DEBUG
    str.gsub(UNICODE_REGEXP) do |matched|
      "&#x#{UNICODE[matched]};"
    end
  end
end
