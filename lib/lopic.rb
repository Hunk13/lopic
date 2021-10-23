require 'nokogiri'
require 'open-uri'
require 'lopic/version'

module Lopic
  URL_REGEXP = %r{^(https?://)?([\w.]+)\.([a-z]{2,6}\.?)(/[\w.]*)*/?$}.freeze
  class << self
    def get_images(input_url)
      return not_valid_url_error unless valid_url?(input_url)

      document = create_document(input_url)
      return nokogiri_error unless document

      images_hash = create_images_array(document)
      success_hash.merge(all_images: images_hash)
    end

    private

    def create_images_array(document)
      images = []
      document.css('img').each do |img|
        src = img['src'].to_s
        alt = img['alt'].to_s
        next if src&.empty? && alt&.empty?

        image_data = {
          src: src,
          alt: alt
        }

        images << image_data
      end

      images
    end

    def valid_url?(uri)
      !!uri.match(URL_REGEXP)
    end

    def not_valid_url_error
      {
        success: false,
        error: 'url is not valid'
      }
    end

    def nokogiri_error
      {
        success: false,
        error: 'error with parsing a document'
      }
    end

    def success_hash
      {
        success: 'true',
        error: ''
      }
    end

    def create_document(input_url)
      Nokogiri::HTML(open(input_url))
    rescue StandardError
      false
    end
  end
end

