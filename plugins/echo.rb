module Gluten::Plugins
  class Echo
    include Gluten::Plugin
    include Cinch::Plugin

    match /echo (.*)/

    def execute(msg, text)
      msg.reply(text)
    end
  end
end
