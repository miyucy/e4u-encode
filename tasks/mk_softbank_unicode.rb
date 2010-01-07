require File.expand_path(File.dirname(__FILE__) + '/task_helper')
module Update
  class Table
    def self.mk_softbank_unicode target
      File.open(target, 'wb') do |out|
        out.print ERB.new(<<'ERB', nil, '-').result
module E4U
  module Encode
    module Softbank
    end
  end
end
class E4U::Encode::Softbank::Unicode
  GOOGLE_UNICODE = {
<% E4U.softbank.each do |e| -%>
<%   softbank = e.softbank_emoji -%>
<%   google = E4U.google.find{|emoji| softbank.unicode == emoji[:softbank] } -%>
    '<%= softbank.unicode.upcase %>' => '<%= google[:google].upcase %>'.freeze,
<% end -%>
  }.freeze

  GOOGLE_UNICODE_REGEXP = Regexp.new("&#x((?i:#{GOOGLE_UNICODE.keys.join('|')}));").freeze
end
ERB
      end
    end
  end
end
