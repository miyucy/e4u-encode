require File.expand_path(File.dirname(__FILE__) + '/task_helper')
module Update
  class Table
    def self.mk_softbank_unicode target

      dat = { }
      E4U.softbank.each do |e|
        google = E4U.google.find{ |g| g[:softbank] == e.softbank_emoji.unicode }
        softbank = e.softbank_emoji.utf8.unpack('U*').map{ |f| "&#x%04X;" % [f] }.join
        dat[softbank] = google[:google].upcase
      end

      E4U.google.each do |e|
        next unless e[:google]
        next unless e[:softbank]
        softbank = e.softbank_emoji.utf8.unpack('U*').map{ |f| "&#x%04X;" % [f] }.join
        next if dat[softbank]
        dat[softbank] =  e[:google].upcase
      end

      File.open(target, 'wb') do |out|
        out.print ERB.new(<<'ERB', nil, '-').result(binding)
class E4U::Encode::Softbank::Unicode
  GOOGLE_UNICODE = {
<% dat.sort.each do |k,v| -%>
    '<%= k %>' => '&#x<%= v %>;'.freeze,
<% end -%>
  }.freeze

  GOOGLE_UNICODE_REGEXP = Regexp.new(GOOGLE_UNICODE.keys.sort_by{ |k| -k.size }.map do |ncr|
                                       "(?:" + ncr.gsub(/&#x(....);/){ "&#x(?i:#{$1});" } + ")"
                                     end.join('|')).freeze
end
ERB
      end
    end
  end
end
