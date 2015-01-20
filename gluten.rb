require 'bundler'
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'gluten'

Bundler.require(:default)
Dotenv.load

bot = Gluten::Bot.new
p Gluten::Config.bot
bot.start
