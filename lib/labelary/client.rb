module Labelary
  class Client
    def self.connection(*args)
      self.new(*args).connection
    end

    def connection
      @connection ||= Faraday.new(url: config.url) do |faraday|
        faraday.request :multipart
        faraday.response :json, content_type: /\bjson$/
        faraday.headers['X-API-Key'] = config.api_key if config.api_key

        faraday.adapter config.http_adapter
      end
    end

    private

    def config
      @config ||= Labelary.configuration
    end

  end
end
