require File.expand_path(File.dirname(__FILE__) + '/task_helper')
module Update
  class Table
    def self.mk_kddi_cp932 target
      File.open(target, 'wb') do |out|
        out.print ERB.new(<<'ERB', nil, '-').result
require 'e4u/encode/docomo/cp932/docomo_unicode'
$KCODE = 'u' if RUBY_VERSION < '1.9.1'
module E4U
  module Encode
    module KDDI
    end
  end
end
class E4U::Encode::KDDI::Cp932
  KDDI_UNICODE = {
<% E4U.kddi.each do |e| -%>
<%   kddi = e.kddiweb_emoji -%>
    ((s = [0x<%= "%X" % kddi.sjis.unpack('n') %>].pack('n')) && RUBY_VERSION < '1.9.1' ? s : s.force_encoding('CP932')) => '<%= kddi.unicode.upcase %>'.freeze,
<% end -%>
  }.merge(E4U::Encode::DoCoMo::Cp932::DOCOMO_UNICODE).freeze

  KDDI_UNICODE_REGEXP = Regexp.union(*KDDI_UNICODE.keys.map(&((RUBY_VERSION < '1.9.1') ?
                                                              (lambda { |e|
                                                                 Regexp.new(Regexp.escape(e,'s'),nil,'s')
                                                               }) :
                                                              (lambda { |e|
                                                                 Regexp.new(Regexp.escape(e))
                                                               })))).freeze
end
ERB
      end
    end
  end
end
