require File.expand_path(File.dirname(__FILE__) + '/task_helper')
module Update
  class Table
    def self.mk_google_utf8 target
      File.open(target, 'wb') do |out|
        out.print ERB.new(<<'ERB', nil, '-').result
module E4U
  module Encode
    module Google
    end
  end
end
class E4U::Encode::Google::Utf8
  UNICODE = {
<% E4U.google.each do |google| -%>
<%   next unless google[:google] -%>
<%   next if google.google_emoji.alternate? -%>
    [0x<%= google[:google] %>].pack('U') => '<%= google[:google] %>'.freeze,
<% end -%>
  }.freeze

  UNICODE_REGEXP = Regexp.union(*UNICODE.keys.map(&((RUBY_VERSION < '1.9.1') ?
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
