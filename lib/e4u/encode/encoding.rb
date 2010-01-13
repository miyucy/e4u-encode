require 'nkf' if RUBY_VERSION < '1.9.1'

module E4U
  module Encode
    module Encoding
      def self.to_utf8 str
        puts "cp932_to_utf8" if $DEBUG
        if RUBY_VERSION < '1.9.1'
          NKF.nkf('-m0wS --ic=CP932', str)
        else
          str.encode('UTF-8')
        end
      end

      def self.to_cp932 str
        puts "utf8_to_cp932" if $DEBUG
        if RUBY_VERSION < '1.9.1'
          NKF.nkf('-m0Ws --oc=CP932', str)
        else
          str.encode('CP932')
        end
      end
    end
  end
end
