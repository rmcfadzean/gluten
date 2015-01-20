lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'bundler'
require 'gluten'

bot = Gluten::Bot.new
# p Gluten::Config.plugins
$redis = Redis.new(:url => ENV["REDISCLOUD_URL"])
bot.start
