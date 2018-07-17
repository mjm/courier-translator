require 'courier/translator/app'

RSpec.describe Courier::Translator::App do
  include Rack::Test::Methods

  def app
    Courier::Translator::App
  end

  let(:translator) { instance_double('Courier::Translator') }

  describe 'GET /' do
    context 'when text is provided in the URL' do
      it 'translates the text provided' do
        expect(Courier::Translator).to receive(:new) { translator }
        expect(translator).to receive(:translate) { 'translated' }
        get '/', 'text' => 'foo bar'
        expect(last_response.body).to eq 'translated'
      end
    end

    context 'when no text is provided in the URL' do
      it 'shows a description of the API' do
        get '/'
        expect(last_response.body).to include '<h1>Courier Translator</h1>'
        expect(last_response.body).to include '<h3>POST <code>/</code></h3>'
      end
    end
  end

  describe 'POST /' do
    it 'translates the text in the body' do
      expect(Courier::Translator).to receive(:new) { translator }
      expect(translator).to receive(:translate) { 'translated' }
      post '/', 'foo bar'
      expect(last_response.body).to eq 'translated'
    end
  end
end
