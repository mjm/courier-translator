require 'config/environment'
require 'translator'

class TranslatorHandler
  def translate(req, _env)
    translator = Translator.new(req.content_html)
    { body: translator.translate }
  end
end

App = Courier::TranslatorService.new(TranslatorHandler.new)
