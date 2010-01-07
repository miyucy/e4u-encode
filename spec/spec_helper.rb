$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'e4u/encode'
require 'spec'
require 'spec/autorun'

require 'nkf'
require 'rubygems'
require 'e4u'

Spec::Runner.configure do |config|

end
