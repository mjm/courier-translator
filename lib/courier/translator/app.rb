require 'sinatra/base'

require 'courier/translator'

module Courier
  class Translator
    # A small app that provides the translator as an HTTP service.
    class App < Sinatra::Base
      get '/' do
        Courier::Translator.new(params['text']).translate
      end

      post '/' do
        Courier::Translator.new(request.body).translate
      end
    end
  end
end
