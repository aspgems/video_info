require 'nokogiri'
require 'open-uri'
require 'active_support/core_ext/object/try'
require 'active_support/core_ext/string/starts_ends_with'

class VideoInfo
  module Providers
    class Tedx < Provider
      def initialize(url, options = {})
        @url = url
        @data = _parse_url
      end
      
      def self.usable?(url)
        url = url.strip
        url =~ %r{(ted\.com\/)} 
      end

      def provider
        'Tedx'
      end

      def title
        @data[:title]
      end

      def author
        @data[:author]
      end

      def embed_url
        @data[:embed_url]
      end

      def url
        @data[:url]
      end

      def thumbnail
        @data[:cover]
      end

      def thumbnail_medium
        @data[:cover] + '?quality=95&w=480'
      end

      def thumbnail_small
        @data[:cover] + '?quality=95&w=120'
      end

      def thumbnail_large
        @data[:cover]
      end

      def description
        @data[:description]
      end
      
      def duration
        @data[:duration]
      end

      def author_thumbnail
        @data[:author_thumbnail]
      end

      def author_url
        @data[:author_url]
      end

      private

      def _parse_url
        doc = Nokogiri::HTML(open(@url))
        data = {url: @url}
        data[:title] = doc.at("meta[name='title']").try('[]', 'content')
        data[:description] = doc.at("meta[name='description']").try('[]', 'content')
        data[:author] = doc.at("meta[name='author']").try('[]', 'content')
        data[:author_thumbnail] = doc.at("link[itemprop='image']").try('[]', 'href')
        data[:author_url] = 'https://www.ted.com/' + doc.at("link[itemprop='url']").try('[]', 'href')
        data[:duration] = doc.at("meta[property='og:video:duration']").try('[]', 'content')
        data[:embed_url] = doc.at("link[itemprop='embedURL']").try('[]', 'href')
        data[:cover] = doc.at("link[itemprop='thumbnailUrl']").try('[]', 'content').split('?').first
        data
      end
      
      def _default_iframe_attributes
        {}
      end

      def _default_url_attributes
        {}
      end
    end
  end
end
