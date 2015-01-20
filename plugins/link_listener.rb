require 'uri'
require 'nokogiri'

module Gluten::Plugins
  class LinkListener
    include Gluten::Plugin
    include Cinch::Plugin

    match /(http(?:s?):\/\/\S*)/, use_prefix: false

    def execute msg, url
      uri = URI.parse(url)

      if $redis.lrange('plugins.link_listener.quiet_domains',0,-1).include? uri.host
        # puts 'This domain is silent'
      else
        conn = Gluten::HTTPClient.new "#{uri.scheme}://#{uri.host}:#{uri.port}"
        resp = conn.get(uri.path)
        title = Nokogiri::HTML(resp.body).css('title').text
        msg.reply title
      end

    end
  end
end
