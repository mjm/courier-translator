require 'nokogiri'
require 'courier/tweet_document'

module Courier
  # Transforms a blog post into text that would make sense to tweet.
  class Translator
    attr_reader :input

    def initialize(input)
      @input = input
    end

    def translate
      parser.parse(input)
      document.contents
    end

    private

    def document
      @document ||= Courier::TweetDocument.new
    end

    def parser
      @parser ||= Nokogiri::HTML::SAX::Parser.new(document)
    end
  end
end

require 'courier/translator/version'
