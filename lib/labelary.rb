require 'active_support'

require 'faraday'
require 'faraday/multipart'

require 'labelary/label'
require 'labelary/image'

require 'labelary/client'
require 'labelary/configuration'
require 'labelary/version'

module Labelary
  def self.font
    Labelary.configuration.font
  end
end