require 'nokogiri'
require 'tweet_document'

# Transforms a blog post into text that would make sense to tweet.
class Translator
  attr_reader :input

  def initialize(input)
    @input = input
  end

  def translate
    return @translated if @translated
    parser.parse(input)
    @translated = document.contents
  end

  private

  def document
    @document ||= TweetDocument.new
  end

  def parser
    @parser ||= Nokogiri::HTML::SAX::Parser.new(document)
  end
end
