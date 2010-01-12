class E4U::Encode::KDDI::Unicode
  %w(CP932 CP932_REGEXP).each do |konst|
    autoload konst, 'e4u/encode/kddi/unicode/cp932'
  end

  %w(UTF8 UTF8_REGEXP).each do |konst|
    autoload konst, 'e4u/encode/kddi/unicode/utf8'
  end

  %w(GOOGLE_UNICODE GOOGLE_UNICODE_REGEXP).each do |konst|
    autoload konst, 'e4u/encode/kddi/unicode/google_unicode'
  end

  def self.to_cp932 str
    puts "kddi_unicode_to_kddi_cp932" if $DEBUG
    str.gsub(CP932_REGEXP) do |matched|
      CP932[$1]
    end
  end

  def self.to_utf8 str
    puts "kddi_unicode_to_kddi_utf8" if $DEBUG
    str.gsub(UTF8_REGEXP) do |matched|
      UTF8[$1]
    end
  end

  def self.to_google_unicode str
    puts "kddi_unicode_to_google_unicode" if $DEBUG
    str.gsub(GOOGLE_UNICODE_REGEXP) do |matched|
      GOOGLE_UNICODE[matched]
    end
  end
end
