module Gluten::Plugins
  class RedisTest
    include Gluten::Plugin
    include Cinch::Plugin

    match /rset (\w*) (\w*)/, method: :rset
    match /rget (\w*)/, method: :rget

    def rset msg, key, value
      $redis.set(key, value)
      msg.reply("#{key} set")
    end

    def rget msg, key
      msg.reply("#{key} => #{$redis.get(key)}")
    end
  end
end
