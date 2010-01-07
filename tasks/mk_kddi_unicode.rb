require File.expand_path(File.dirname(__FILE__) + '/task_helper')
module Update
  class Table
    def self.mk_kddi_unicode target
      File.open(target, 'wb') do |out|
        out.print ERB.new(<<'ERB', nil, '-').result
require 'e4u/encode/docomo/unicode/google_unicode'
module E4U
  module Encode
    module KDDI
    end
  end
end
class E4U::Encode::KDDI::Unicode
  GOOGLE_UNICODE = {
<% E4U.kddi.each do |e| -%>
<%   kddi = e.kddi_emoji -%>
<%   kddiweb = e.kddiweb_emoji -%>
<%   google = E4U.google.find{|emoji| kddi.unicode == emoji[:kddi] } -%>
    '<%= kddiweb.unicode.upcase %>' => '<%= google[:google].upcase %>'.freeze,
<% end -%>
  }.merge(E4U::Encode::DoCoMo::Unicode::GOOGLE_UNICODE).freeze

  GOOGLE_UNICODE_REGEXP = Regexp.new("&#x((?i:#{GOOGLE_UNICODE.keys.join('|')}));").freeze
end
ERB
      end
    end
  end
end
