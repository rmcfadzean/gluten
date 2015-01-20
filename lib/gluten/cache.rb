module Gluten
  class Cache
    def initialize
      @cache = Dalli::Client.new((ENV['MEMCACHIER_SERVERS'] || '').split(','),
        {
          username: ENV['MEMCACHIER_USERNAME'],
          password: ENV['MEMCACHIER_PASSWORD'],
          failover: true,
          socket_timeout: 1.5,
          socket_failure_delay: 0.2,
          expires_in: 300
        }
      )
    end

    def read key
      @cache.get(key)
    end

    def write key, value
      @cache.set(key,value)
    end
  end
end
