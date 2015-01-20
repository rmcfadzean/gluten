module Gluten::Plugins
  class Version
    include Gluten::Plugin
    include Cinch::Plugin

    match /version/

    def execute msg
      msg.reply "GlutenBot Version #{Gluten::VERSION}"
    end
  end
end
