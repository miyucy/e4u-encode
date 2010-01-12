require File.expand_path(File.dirname(__FILE__) + '/task_helper')
module Update
  class Table
    def self.mk_kddi_unicode target

      dat = { }
      E4U.kddi.each do |e|
        google = E4U.google.find{ |g| g[:kddi] == e.kddi_emoji.unicode }
        kddi = e.kddi_emoji.utf8.unpack('U*').map{ |f| "&#x%04X;" % [f] }.join
        dat[kddi] = google[:google].upcase
        kddi = e.kddiweb_emoji.utf8.unpack('U*').map{ |f| "&#x%04X;" % [f] }.join
        dat[kddi] = google[:google].upcase
      end

      E4U.google.each do |e|
        next unless e[:google]
        next unless e[:kddi]
        kddi = e.kddi_emoji.utf8.unpack('U*').map{ |f| "&#x%04X;" % [f] }.join
        unless dat[kddi]
          dat[kddi] =  e[:google].upcase
        end
        kddi = e.kddiweb_emoji.utf8.unpack('U*').map{ |f| "&#x%04X;" % [f] }.join
        unless dat[kddi]
          dat[kddi] =  e[:google].upcase
        end
      end

      File.open(target, 'wb') do |out|
        out.print ERB.new(<<'ERB', nil, '-').result(binding)
require 'e4u/encode/docomo/unicode/google_unicode'
class E4U::Encode::KDDI::Unicode
  GOOGLE_UNICODE = {
<% dat.sort.each do |k,v| -%>
    '<%= k %>' => '&#x<%= v %>;'.freeze,
<% end -%>
  }.merge(E4U::Encode::DoCoMo::Unicode::GOOGLE_UNICODE).freeze

  GOOGLE_UNICODE_REGEXP = Regexp.new(GOOGLE_UNICODE.keys.sort_by{ |k| -k.size }.map do |ncr|
                                       "(?:" + ncr.gsub(/&#x(....);/){ "&#x(?i:#{$1});" } + ")"
                                     end.join('|')).freeze
end
ERB
      end
    end
  end
end
