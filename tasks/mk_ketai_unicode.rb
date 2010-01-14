require File.expand_path(File.dirname(__FILE__) + '/task_helper')
module Update
  class Table
    def self.mk_ketai_unicode target
      dat = { }
      E4U.google.each do |e|
        next unless e[:google]
        key = "[e:#{"%03X" % [e[:id].hex]}]"
        val = e.google_emoji.utf8.unpack('U*').map{ |f| "&#x%04X;" % [f] }.join
        dat[key] = val
      end

      File.open(target, 'wb') do |out|
        out.print ERB.new(<<'ERB', nil, '-').result(binding)
class E4U::Encode::Ketai::Unicode
  GOOGLE_UNICODE = {
<% dat.sort.each do |k,v| -%>
    '<%= k %>' => '<%= v %>'.freeze,
<% end -%>
  }.freeze

  GOOGLE_UNICODE_REGEXP = Regexp.union(*GOOGLE_UNICODE.keys.map{ |k| Regexp.new(Regexp.escape(k)) }).freeze
end
ERB
      end
    end
  end
end
