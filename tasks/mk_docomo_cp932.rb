require File.expand_path(File.dirname(__FILE__) + '/task_helper')
module Update
  class Table
    def self.mk_docomo_cp932 target
      File.open(target, 'wb') do |out|
        out.print ERB.new(<<'ERB', nil, '-').result
$KCODE = 'u' if RUBY_VERSION < '1.9.1'
module E4U
  module Encode
    module DoCoMo
    end
  end
end
class E4U::Encode::DoCoMo::Cp932
  DOCOMO_UNICODE = {
<% E4U.docomo.each do |e| -%>
<%   docomo = e.docomo_emoji -%>
    ((s = [0x<%= "%X" % docomo.sjis.unpack('n') %>].pack('n')) && RUBY_VERSION < '1.9.1' ? s : s.force_encoding('CP932')) => '<%= docomo.unicode.upcase %>'.freeze,
<% end -%>
  }.freeze

  DOCOMO_UNICODE_REGEXP = Regexp.union(*DOCOMO_UNICODE.keys.map(&((RUBY_VERSION < '1.9.1') ?
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
