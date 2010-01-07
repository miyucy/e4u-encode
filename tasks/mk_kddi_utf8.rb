require File.expand_path(File.dirname(__FILE__) + '/task_helper')
module Update
  class Table
    def self.mk_kddi_utf8 target
      File.open(target, 'wb') do |out|
        out.print ERB.new(<<'ERB', nil, '-').result
require 'e4u/encode/docomo/utf8/docomo_unicode'
module E4U
  module Encode
    module KDDI
    end
  end
end
class E4U::Encode::KDDI::Utf8
  KDDI_UNICODE = {
<% E4U.kddi.each do |e| -%>
<%   kddi = e.kddiweb_emoji -%>
<%   kddiapp = e.kddi_emoji -%>
    [0x<%= kddi.unicode %>].pack('U') => '<%= kddi.unicode.upcase %>'.freeze,
    [0x<%= kddiapp.unicode %>].pack('U') => '<%= kddi.unicode.upcase %>'.freeze,
<% end -%>
  }.merge(E4U::Encode::DoCoMo::Utf8::DOCOMO_UNICODE).freeze

  KDDI_UNICODE_REGEXP = Regexp.union(*KDDI_UNICODE.keys.map(&((RUBY_VERSION < '1.9.1') ?
                                                              (lambda { |e|
                                                                 Regexp.new(Regexp.escape(e,'u'),nil,'u')
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
