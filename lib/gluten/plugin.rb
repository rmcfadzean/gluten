module Gluten
  module Plugin
    def cache
      Gluten::Cache.new
    end

    def twitter_client
      Twitter::REST::Client.new do |config|
        config.consumer_key             = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret          = ENV['TWITTER_CONSUMER_SECRET']

        config.access_token             = ENV['TWITTER_ACCESS_TOKEN']
        config.access_token_secret      = ENV['TWITTER_ACCESS_SECRET']
      end
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
