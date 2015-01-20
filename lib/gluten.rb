plugin_path = File.expand_path('../../plugins',__FILE__)
$LOAD_PATH.unshift(plugin_path) unless $LOAD_PATH.include?(plugin_path)

Bundler.require(:default)
Dotenv.load

require 'gluten/version'
require 'gluten/config'
require 'gluten/cache'
require 'gluten/bot'
require 'gluten/http_client'
require 'gluten/plugin'
