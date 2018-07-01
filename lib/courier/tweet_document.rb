require 'nokogiri'

module Courier
  # Document for parsing a post that is being translated into a tweet
  class TweetDocument < Nokogiri::XML::SAX::Document
    attr_reader :contents

    def initialize
      @contents = ''
      @urls = []
    end

    def start_element(name, attrs = [])
      case name
      when 'a'
        attrs = Hash[attrs]
        @urls << attrs['href'] if attrs.key? 'href'
      when 'blockquote'
        contents << '"'
      end
    end

    def characters(string)
      contents << string.gsub(/\s+/, ' ')
    end

    def end_element(name)
      case name
      when 'p'
        contents << "\n\n"
      when 'br'
        contents << "\n"
      when 'blockquote'
        contents << '"'
      end
    end

    def end_document
      contents.strip!
      contents << " #{@urls.join(' ')}" unless @urls.empty?
    end
  end
end
