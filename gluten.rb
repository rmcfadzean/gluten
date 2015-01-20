require 'bundler'
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

plugin_path = File.expand_path('../plugins',__FILE__)
$LOAD_PATH.unshift(plugin_path) unless $LOAD_PATH.include?(plugin_path)

require 'gluten'

Bundler.require(:default)
Dotenv.load

bot = Gluten::Bot.new
p Gluten::Config.plugins
$redis = Redis.new(:url => ENV["REDISCLOUD_URL"])
bot.start
