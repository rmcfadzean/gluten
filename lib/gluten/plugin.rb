require 'cinch/plugin'

module Gluten
  module Plugin

    attr_accessor :redis_set
    attr_accessor :redis_get

    def redis_set key, value
      $redis.set(key, value)
    end

    def redis_get key
      $redis.get(key)
    end

  end

  module Plugins
    def self.load_all
      Config.plugins.each do |plugin|
        puts "Loading: #{plugin}"
        require plugin
      end
    end
  end
end
