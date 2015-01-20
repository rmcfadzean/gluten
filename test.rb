require 'faraday/http_cache'
require 'active_support/logger'
require 'bundler'
Bundler.require(:default)
Dotenv.load
class Cache
  def initialize
    @cache = Dalli::Client.new((ENV['MEMCACHIER_SERVERS'] || '').split(','),
    {
      username: ENV['MEMCACHIER_USERNAME'],
      password: ENV['MEMCACHIER_PASSWORD'],
      failover: true,
      socket_timeout: 1.5,
      socket_failure_delay: 0.2
    }
    )
  end

  def read key
    puts "Cache Read: #{key}"
    @cache.get(key)
  end

  def write key, value
    puts "Cache Write: #{key}"
    @cache.set(key,value)
  end
end



10.times do |index|

  client = Faraday.new('https://api.github.com') do |stack|
    stack.use :http_cache, logger: ActiveSupport::Logger.new(STDOUT), store: Cache.new
    stack.adapter Faraday.default_adapter
  end

  started = Time.now
  puts "Request ##{index+1}"
  response = client.get('repos/plataformatec/faraday-http-cache')
  finished = Time.now
  remaining = response.headers['X-RateLimit-Remaining']
  limit = response.headers['X-RateLimit-Limit']
  # sleep 1

  puts "  Request took #{(finished - started) * 1000} ms."
  puts "  Rate limits: remaining #{remaining} requests of #{limit}."
end
