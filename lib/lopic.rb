require 'nokogiri'
require 'open-uri'
require 'lopic/version'

module Lopic
  class << self
    def get_images(input_url)
      return not_valid_url_error unless valid_url?(input_url)

      document = create_document(input_url)
      return nokogiri_error if document == false

      images_hash = create_images_array(document)
      success_hash.merge(all_images: images_hash)
    end

    private

    def create_images_array(document)
      array = []
      document.css('img').each do |node|
        if !node['alt'].nil?
        array.push(
          src: node['src'],
          alt: node['alt']
        )
        else
        array.push(
          src: node['src']
        )
        end
      end
      array
    end

    def valid_url?(uri)
      !!uri.match(/^(https?:\/\/)?([\w\.]+)\.([a-z]{2,6}\.?)(\/[\w\.]*)*\/?$/)
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
        succes: 'true',
        error: ''
      }
    end

    def create_document(input_url)
      Nokogiri::HTML(open(input_url))
    rescue
      false
    end
  end
end
