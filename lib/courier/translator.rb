module Courier
  # Transforms a blog post into text that would make sense to tweet.
  class Translator
    attr_reader :input

    def initialize(input)
      @input = input
    end

    def translate
      input
    end
  end
end

require 'courier/translator/version'
