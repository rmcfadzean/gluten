module Gluten
  class Config
    class << self

      SERVER_DEFAULTS = {host: 'localhost', port: 6667, channels: '#bot-test', ssl: false}
      BOT_DEFAULTS = {nicks: 'Gluten', realname: 'Gluten', user: 'Gluten'}

      def server
        {
          host: ENV['IRC_SERVER'] || SERVER_DEFAULTS[:host],
          port: ENV['IRC_PORT'] || SERVER_DEFAULTS[:port],
          channels: ENV['IRC_CHANNELS'] || SERVER_DEFAULTS[:channels]
        }
      end

      def bot
        {
          nicks: ENV['BOT_NICKS'] || BOT_DEFAULTS[:nicks],
          realname: ENV['BOT_REALNAME'] || BOT_DEFAULTS[:realname],
          user: ENV['BOT_USER'] || BOT_DEFAULTS[:user]
        }
      end

      def plugins
        ENV['BOT_PLUGINS'].split(',')
      end

      def const_plugins
        self.plugins.map{|plugin|
          camelized = plugin.split('_').map!{|s|s.capitalize}.join
          Kernel.const_get("Gluten::Plugins::#{camelized}")
        }
      end
    end
  end
end
