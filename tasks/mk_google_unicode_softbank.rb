require File.expand_path(File.dirname(__FILE__) + '/task_helper')
module Update
  class Table
    def self.mk_google_unicode_softbank target
      File.open(target, 'wb') do |out|
        out.print ERB.new(<<'ERB', nil, '-').result
# -*- coding:utf-8 -*-
module E4U
  module Encode
    module Google
    end
  end
end
class E4U::Encode::Google::Unicode
  SOFTBANK_UNICODE = {
<% E4U.google.each do |data| -%>
<%   next unless data[:google] -%>
<%   if data[:softbank] -%>
<%     google = data.google_emoji -%>
<%     next if google.alternate? -%>
<%     softbank = data.softbank_emoji -%>
    '<%= google.google %>' => "<%= softbank.utf8.unpack('U*').map{ |e| "&#x%04X;" % e }.join %>".freeze,
<%   else -%>
<%     google = data.google_emoji -%>
<%     text = google.text_fallback || google.text_repr || [0x3013].pack('U') -%>
    '<%= google.google %>' => "<%= text %>".freeze,
<%   end -%>
<% end -%>
  }.freeze

  SOFTBANK_UNICODE_REGEXP = Regexp.new("&#x((?i:#{SOFTBANK_UNICODE.keys.join('|')}));").freeze
end
ERB
      end
    end
  end
end
