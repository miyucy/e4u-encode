require File.expand_path(File.dirname(__FILE__) + '/task_helper')
module Update
  class Table
    def self.mk_softbank_cp932 target
      File.open(target, 'wb') do |out|
        out.print ERB.new(<<'ERB', nil, '-').result
$KCODE = 'u' if RUBY_VERSION < '1.9.1'
module E4U
  module Encode
    module Softbank
    end
  end
end
class E4U::Encode::Softbank::Cp932
  SOFTBANK_UNICODE = {
<% E4U.softbank.each do |e| -%>
<%   softbank = e.softbank_emoji -%>
    ((s = [0x<%= "%X" % softbank.sjis.unpack('n') %>].pack('n')) && RUBY_VERSION < '1.9.1' ? s : s.force_encoding('CP932')) => '<%= softbank.unicode.upcase %>'.freeze,
<% end -%>
  }.freeze

  SOFTBANK_UNICODE_REGEXP = Regexp.union(*SOFTBANK_UNICODE.keys.map(&((RUBY_VERSION < '1.9.1') ?
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
