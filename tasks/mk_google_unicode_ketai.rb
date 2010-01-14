require File.expand_path(File.dirname(__FILE__) + '/task_helper')
module Update
  class Table
    def self.mk_google_unicode_ketai target
      File.open(target, 'wb') do |out|
        out.print ERB.new(<<'ERB', nil, '-').result
class E4U::Encode::Google::Unicode
  KETAI_UNICODE = {
<% E4U.google.each do |data| -%>
<%   next unless data[:google] -%>
<%   google = data.google_emoji -%>
<%   next if google.alternate? -%>
    '<%= google.utf8.unpack('U').map{ |e| "%05X" % e }.join %>' => '<%= "[e:%03X]" % [data[:id].hex] %>'.freeze,
<% end -%>
  }.freeze

  KETAI_UNICODE_REGEXP = Regexp.new("&#x((?i:#{KETAI_UNICODE.keys.join('|')}));").freeze
end
ERB
      end
    end
  end
end
