class E4U::Encode::Ketai::Unicode
  %w(GOOGLE_UNICODE GOOGLE_UNICODE_REGEXP).each do |konst|
    autoload konst, 'e4u/encode/ketai/unicode/google_unicode'
  end

  def self.to_google_unicode str
    puts "ketai_unicode_to_google_unicode" if $DEBUG
    str.gsub(GOOGLE_UNICODE_REGEXP) do |matched|
      GOOGLE_UNICODE[matched]
    end
  end
end
