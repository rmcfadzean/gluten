module Gluten
  class Bot
    attr :bot

    def initialize
      @bot = Cinch::Bot.new do
        configure do |c|
          c.server = Config.server[:host]
          c.port = Config.server[:port]
          c.channels = Config.server[:channels].split(',')

          c.nicks = Config.bot[:nicks].split(',')
          c.user = Config.bot[:user]
          c.realname = Config.bot[:realname]
        end
      end
    end

    def start
      @bot.start
    end

  end
end
