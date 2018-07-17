require 'sinatra/base'

require 'courier/translator'

module Courier
  class Translator
    # A small app that provides the translator as an HTTP service.
    class App < Sinatra::Base
      get '/' do
        if params.key?('text')
          Courier::Translator.new(params['text']).translate
        else
          markdown <<'HOME'
# Courier Translator

This is a microservice that translates HTML blog post content into well-formatted tweets.

## How to Use

The service supports GET or POST requests to provide input to the translator.

### GET `/?text=[text]`

Pass the input HTML as a URL-encoded value to the `text` query parameter. The response body will be the translated tweet content.

### POST `/`

Pass the input HTML as the body of the POST request. The response body will be the translated tweet content.
HOME
        end
      end

      post '/' do
        Courier::Translator.new(request.body).translate
      end
    end
  end
end
