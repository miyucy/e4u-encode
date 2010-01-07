class E4U::Encode::Softbank::Cp932
  %w(SOFTBANK_UNICODE SOFTBANK_UNICODE_REGEXP).each do |konst|
    autoload konst, 'e4u/encode/softbank/cp932/softbank_unicode'
  end

  def self.to_softbank_unicode str
    puts "softbank_cp932_to_softbank_unicode" if $DEBUG
    webcode_to_unicode(str).gsub(SOFTBANK_UNICODE_REGEXP) do |matched|
      "&#x#{SOFTBANK_UNICODE[matched]};"
    end
  end

  private

  WEBCODE_OFFSET = {
    'G' => 0xE000,
    'E' => 0xE100,
    'F' => 0xE200,
    'O' => 0xE300,
    'P' => 0xE400,
    'Q' => 0xE500,
  }.freeze

  def self.webcode_to_unicode str
    str.gsub(/\x1B\x24([GEFOPQ])([\x21-\x7A]+)\x0F/n) do |matched|
      high, code = $1, $2
      code.unpack('C*').map do |ch|
        "&#x%04X;" % [WEBCODE_OFFSET[high] - 32 + ch]
      end.join
    end
  end
end
