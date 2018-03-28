require 'nokogiri'
require 'open-uri'
require 'active_support/core_ext/object/try'
require 'active_support/core_ext/string/starts_ends_with'

class VideoInfo
  module Providers
    class Tedx < Provider
      def initialize(url, options = {})
        @url = url
        @talk = _parse_url
      end
      
      def self.usable?(url)
        url = url.strip
        url =~ %r{(ted\.com\/)} 
      end

      def provider
        'Tedx'
      end

      private

      def _parse_url
        slug = @url.split('/').last
        query = slug.split('_')[0..1].join('+')
        search_url = 'https://www.ted.com/talks?q=' + query
        doc = Nokogiri::HTML(open(search_url))
        talk_data = {}
        doc.css('div.talk-link').each do |talk|
          talk_path = talk.css('a.ga-link').first.try(:attr, 'href')
          if talk_path.ends_with?(slug)
            talk_data = {
            cover: talk.css('img.thumb__image').first.try(:attr, 'src'),
            title: talk.css('h4.h9.m5 a').first.try(:content).try(:strip),
            author: talk.css('h4.talk-link__speaker').first.try(:content).try(:strip),
            embed_url: 'https://embed.ted.com' + talk_path,
            url: url
            }
            break
          end
        end
        talk_data
      end

      def _api_base
      end

      def _api_path
      end

      def _api_url
      end

      def _url_regex
      end

    end
  end
end
