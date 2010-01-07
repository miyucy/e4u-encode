require File.expand_path(File.dirname(__FILE__) + '/task_helper')
module Update
  class Table
    def self.mk_google_unicode_kddi target
      File.open(target, 'wb') do |out|
        out.print ERB.new(<<'ERB', nil, '-').result
module E4U
  module Encode
    module Google
    end
  end
end
class E4U::Encode::Google::Unicode
  KDDI_UNICODE = {
<% E4U.google.each do |data| -%>
<%   next unless data[:google] -%>
<%   if data[:kddi] -%>
<%     google = data.google_emoji -%>
<%     next if google.alternate? -%>
<%     kddi = data.kddiweb_emoji -%>
    '<%= google.google %>' => "<%= kddi.utf8.unpack('U*').map{ |e| "&#x%04X;" % e }.join %>".freeze,
<%   else -%>
<%     google = data.google_emoji -%>
<%     text = google.text_fallback || google.text_repr || [0x3013].pack('U') -%>
    '<%= google.google %>' => <%= text.dump %>.freeze,
<%   end -%>
<% end -%>
  }.freeze

  KDDI_UNICODE_REGEXP = Regexp.new("&#x((?i:#{KDDI_UNICODE.keys.join('|')}));").freeze
end
ERB
      end
    end
  end
end
