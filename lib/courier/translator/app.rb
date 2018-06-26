require 'sinatra/base'

module Courier
  class Translator
    # A small app that provides the translator as an HTTP service.
    class App < Sinatra::Base
      get '/' do
        'Hello world!'
      end
    end
  end
end
