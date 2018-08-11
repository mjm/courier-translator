require 'config/environment'
require 'translator'

class TranslatorHandler
  def translate(req, _env)
    translator = Translator.new(req.content_html)
    {
      tweets: [
        Courier::TranslatedTweet.new(body: translator.tweets.first,
                                     media_urls: translator.media_urls)
      ]
    }
  end
end

App = Courier::TranslatorService.new(TranslatorHandler.new)
