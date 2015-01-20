module Gluten
  class HTTPClient
    attr_reader :connection

    def initialize url
      @connection = Faraday.new(url: url) do |faraday|
        faraday.use :http_cache, store: Gluten::Cache.new, serializer: Marshal
        faraday.use FaradayMiddleware::FollowRedirects
        # faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end

    def get path, params = nil
      @connection.get(path, params)
    end
  end
end
