require 'pp'
require 'rubygems'

require 'irb/completion'

begin
  require 'sketches'
  Sketches.config :editor => 'mate'
rescue LoadError
  'please run: `sudo gem install sketches`'
end

begin
  require 'wirble'
  Wirble.init(:history_size => 10000)
  Wirble.colorize


rescue LoadError
  puts "please run: `sudo gem install wirble`"
end

begin
  require 'hirb'
  Hirb.enable
rescue LoadError
  puts "please run: `sudo gem install hirb`"
end

class Object
  # Return a list of methods defined locally for a particular object.  Useful
  # for seeing what it does whilst losing all the guff that's implemented
  # by its parents (eg Object).
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end
end

# Log to STDOUT if in Rails
if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  require 'logger'
  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
end