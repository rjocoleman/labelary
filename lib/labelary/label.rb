module Labelary
  class Label
    def self.render(**args)
      self.new(**args).render
    end

    def initialize(dpmm: nil, width: nil, height: nil, index: nil, zpl:, content_type: nil, font: nil)
      @zpl    ||= zpl
      @dpmm   ||= dpmm   || config.dpmm
      @width  ||= width  || config.width
      @height ||= height || config.height
      @index  ||= index  || config.index
      @content_type ||= content_type || config.content_type
      @font ||= font || config.font

      raise 'Invalid dpmm'   if @dpmm.nil?
      raise 'Invalid width'  if @width.nil?
      raise 'Invalid height' if @height.nil?
    end

    # http://labelary.com/service.html
    def render
      payload = font_string + @zpl
      response = Labelary::Client.connection.post "/v1/printers/#{@dpmm}dpmm/labels/#{@width}x#{@height}/#{@index}/", payload, { Accept: @content_type }
      return response.body
    end

    def font_string
      @font.present? ? @font.to_s : ''
    end

    private

    def config
      @config ||= Labelary.configuration
    end

  end
end
