module Labelary
  class Image
    def self.encode(**args)
      self.new(**args).encode
    end

    def initialize(path:nil, mime_type:, filename:nil, file_io:nil)
      if path.present?
        @file = Faraday::UploadIO.new path, mime_type
      elsif file_io.present? && filename.present?
        @file = Faraday::UploadIO.new file_io, mime_type, filename
      else
        raise 'Path to image and MIME type or an IO object, filename and MIME type must be specified.'
      end
    end

    # http://labelary.com/faq.html#image-conversion
    def encode
      response = Labelary::Client.connection.post '/v1/graphics', { file: @file }, { Accept: 'application/json' }
      image = response.body

      return '^GFA,' + image['totalBytes'].to_s + ',' + image['totalBytes'].to_s + ',' + image['rowBytes'].to_s + ',' + image['data'] + '^FS'
    end

  end
end
