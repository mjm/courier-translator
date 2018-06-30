require 'nokogiri'

module Courier
  # Document for parsing a post that is being translated into a tweet
  class TweetDocument < Nokogiri::XML::SAX::Document
    attr_reader :contents

    def initialize
      @contents = ''
    end

    def start_element(name, attrs = [])
    end

    def characters(string)
      @contents << string
    end

    def end_element(name)
      case name
      when 'p'
        contents << "\n\n"
      end
    end

    def end_document
      @contents.chomp! ''
    end
  end
end
