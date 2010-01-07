require File.expand_path(File.dirname(__FILE__) + '/task_helper')
module Update
  class Table
    def self.mk_docomo_unicode target
      File.open(target, 'wb') do |out|
        out.print ERB.new(<<'ERB', nil, '-').result
module E4U
  module Encode
    module DoCoMo
    end
  end
end
class E4U::Encode::DoCoMo::Unicode
  GOOGLE_UNICODE = {
<% E4U.docomo.each do |e| -%>
<%   docomo = e.docomo_emoji -%>
<%   google = E4U.google.find{|emoji| docomo.unicode == emoji[:docomo] } -%>
    '<%= docomo.unicode.upcase %>' => '<%= google[:google].upcase %>'.freeze,
<% end -%>
  }.freeze

  GOOGLE_UNICODE_REGEXP = Regexp.new("&#x((?i:#{GOOGLE_UNICODE.keys.join('|')}));").freeze
end
ERB
      end
    end
  end
end
