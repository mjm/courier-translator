RSpec.describe TranslatorHandler do
  subject { App }

  let(:translator) do
    instance_double(Translator, tweets: ['translated'], media_urls: [])
  end
  before { allow(Translator).to receive(:new) { translator } }

  describe '#translate' do
    let(:request) { { content_html: 'foo bar' } }
    let(:response) { subject.call_rpc(:Translate, request, {}) }

    it 'translates the HTML provided' do
      expect(Translator).to receive(:new).with('foo bar')
      expect(translator).to receive(:tweets)
      expect(response.tweets).to eq [
        Courier::TranslatedTweet.new(body: 'translated')
      ]
    end

    context 'when the there is media attached to the post' do
      it 'returns the URLs of the included media' do
        expect(translator).to receive(:tweets)
        expect(translator).to receive(:media_urls).and_return(%w[https://example.com/foo.jpg])

        expect(response.tweets.first.media_urls).to eq %w[https://example.com/foo.jpg]
      end
    end
  end
end
