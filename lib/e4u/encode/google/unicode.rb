class E4U::Encode::Google::Unicode
  %w(UTF8 UTF8_REGEXP).each do |konst|
    autoload konst, 'e4u/encode/google/unicode/utf8'
  end

  %w(DOCOMO_UNICODE DOCOMO_UNICODE_REGEXP).each do |konst|
    autoload konst, 'e4u/encode/google/unicode/docomo_unicode'
  end

  %w(KDDI_UNICODE KDDI_UNICODE_REGEXP).each do |konst|
    autoload konst, 'e4u/encode/google/unicode/kddi_unicode'
  end

  %w(SOFTBANK_UNICODE SOFTBANK_UNICODE_REGEXP).each do |konst|
    autoload konst, 'e4u/encode/google/unicode/softbank_unicode'
  end

  def self.to_utf8 str
    puts "google_unicode_to_google_utf8" if $DEBUG
    str.gsub(UTF8_REGEXP) do |matched|
      UTF8[$1.upcase]
    end
  end

  def self.to_docomo_unicode str
    puts "google_unicode_to_docomo_unicode" if $DEBUG
    str.gsub(DOCOMO_UNICODE_REGEXP) do |matched|
      DOCOMO_UNICODE[$1.upcase]
    end
  end

  def self.to_kddi_unicode str
    puts "google_unicode_to_kddi_unicode" if $DEBUG
    str.gsub(KDDI_UNICODE_REGEXP) do |matched|
      KDDI_UNICODE[$1.upcase]
    end
  end

  def self.to_softbank_unicode str
    puts "google_unicode_to_softbank_unicode" if $DEBUG
    str.gsub(SOFTBANK_UNICODE_REGEXP) do |matched|
      SOFTBANK_UNICODE[$1.upcase]
    end
  end
end
