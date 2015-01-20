module Gluten::Plugins
  class RedisTest
    include Gluten::Plugin
    include Cinch::Plugin

    match /rset (\w*) (\w*)/, method: :rset
    match /rget (\w*)/, method: :rget

    def rset(msg, key, value)
      redis_set(key, value)
      msg.reply("#{key} set")
    end

    def rget(msg, key)
      value = redis_get(key)
      msg.reply("#{key} => #{value}")
    end
  end
end
