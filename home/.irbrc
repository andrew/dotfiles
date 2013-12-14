puts 'loading ~/.irbrc'
require 'pp'
require 'rubygems'

require 'irb/completion'
require 'irb/ext/save-history'

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-history"

class Object
  # Return a list of methods defined locally for a particular object.  Useful
  # for seeing what it does whilst losing all the guff that's implemented
  # by its parents (eg Object).
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end
end

# Log to STDOUT if in Rails
if Object.const_defined?('ActiveRecord')
  puts "Loading Rails SQL logger"
  ActiveRecord::Base.connection.instance_variable_set :@logger, Logger.new(STDOUT)
end
