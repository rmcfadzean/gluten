module Gluten::Plugins
  class Settings
    include Gluten::Plugin
    include Cinch::Plugin

    match /settings get (.*)/, method: :get_key
    match /settings set (\w*) (\w*)/, method: :set_key

    match /settings append (\S*) (\S*)/, method: :append_key
    match /settings getrange (\S*) (\d*),([-\d]*)/, method: :get_range

    def get_key msg, key
      if key == 'all'
        keys = $redis.keys("settings.#{msg.user.nick}.*")
        values = $redis.mget(keys)

        response = {}
        keys.map.with_index {|key,index|
          response[key] = values[index]
        }
      else
        value = $redis.get("settings.#{msg.user.nick}.#{key}")
        if value
          response = {"#{key}": value}
        else
          response = "No value for '#{key}'"
        end
      end

      msg.user.send(response)
    end

    def set_key msg, key, value
      if $redis.set(key, value)
        msg.user.send("'#{key}' set to '#{value}'")
      else
        msg.user.send("Error setting '#{key}'")
      end
    end

    def append_key msg, key, value
      if $redis.rpush(key, value)
        response = $redis.lrange(key,0,-1)
      else
        response "Error appending #{value} to #{key}"
      end
      msg.user.send response
    end

    def get_range msg, key, min, max
      msg.user.send $redis.lrange(key, min, max)
    end

  end
end
