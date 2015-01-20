require 'twitter'

module Gluten::Plugins
  class TweetReader
    include Cinch::Plugin
    include Gluten::Plugin

    match /twitter.com\/(\w*)\/status\/(\d*)/, method: :read_tweet, use_prefix: false
    match /twitter.com\/(\w*)\/$/, method: :user_info, use_prefix: false

    def read_tweet msg, user, tweet_id
      if cached_tweet = cache.read("tweets.#{tweet_id}")
        tweet_text = cached_tweet
      else
        tweet_text = twitter_client.status(tweet_id).full_text
        cache.write("tweets.#{tweet_id}",tweet_text)
      end
      msg.reply("@#{user} => #{tweet_text}")
    end

    def user_info msg, user
      user = twitter_client.user(user)
      msg.reply "#{user.name} (#{user.location}) - #{user.description}"
    end
  end
end
