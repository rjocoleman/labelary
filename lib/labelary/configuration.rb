module Labelary
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end

  class Configuration
    attr_accessor *[
      :url,
      :api_key,
      :http_adapter,
      :dpmm,
      :width,
      :height,
      :index,
      :content_type,
      :font
    ]

    def initialize
      @url          = 'http://api.labelary.com'
      @http_adapter = Faraday.default_adapter
      @api_key      = nil
      @dpmm         = nil
      @width        = nil
      @height       = nil
      @index        = ''
      @content_type = 'image/png'
      @font         = ''
    end

  end
end
