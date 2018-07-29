require 'courier/translator/version'
require 'courier/translator/service_twirp'

class Courier::TranslatorClient
  class << self
    def connect(**options)
      new(create_connection(**options))
    end

    private

    def create_connection(url: ENV['COURIER_TRANSLATOR_URL'],
                          logger: false)
      Faraday.new(url) do |conn|
        conn.response :logger if logger
        conn.adapter :typhoeus
      end
    end
  end
end
