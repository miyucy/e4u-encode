class E4U::Encode::Softbank::Unicode
  %w(CP932 CP932_REGEXP).each do |konst|
    autoload konst, 'e4u/encode/softbank/unicode/cp932'
  end

  %w(UTF8 UTF8_REGEXP).each do |konst|
    autoload konst, 'e4u/encode/softbank/unicode/utf8'
  end

  %w(GOOGLE_UNICODE GOOGLE_UNICODE_REGEXP).each do |konst|
    autoload konst, 'e4u/encode/softbank/unicode/google_unicode'
  end

  def self.to_cp932 str
    puts "softbank_unicode_to_softbank_cp932" if $DEBUG
    str.gsub(CP932_REGEXP) do |matched|
      CP932[$1]
    end
  end

  def self.to_webcode str
    puts "softbank_unicode_to_softbank_cp932" if $DEBUG
    str.gsub(CP932_REGEXP) do |matched|
      code = $1.hex
      high = %w(G E F O P Q)[(code & 0x0700) >> 8]
      low  = (code & 0xFF) + 32
      webcode = "\x1B\x24" + high + low.chr + "\x0F"
      RUBY_VERSION < '1.9.1' ? webcode : webcode.force_encoding('CP932')
    end
  end

  def self.to_utf8 str
    puts "softbank_unicode_to_softbank_utf8" if $DEBUG
    str.gsub(UTF8_REGEXP) do |matched|
      UTF8[$1]
    end
  end

  def self.to_google_unicode str
    puts "softbank_unicode_to_google_unicode" if $DEBUG
    str.gsub(GOOGLE_UNICODE_REGEXP) do |matched|
      "&#x#{GOOGLE_UNICODE[$1]};"
    end
  end
end
