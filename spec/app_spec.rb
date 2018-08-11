RSpec.describe TranslatorHandler do
  subject { App }

  let(:translator) { instance_double(Translator) }
  before { allow(Translator).to receive(:new) { translator } }

  describe '#translate' do
    let(:request) { { content_html: 'foo bar' } }
    let(:response) { subject.call_rpc(:Translate, request, {}) }

    it 'translates the HTML provided' do
      expect(Translator).to receive(:new).with('foo bar')
      expect(translator).to receive(:tweets).and_return(%w[translated])
      expect(response.body).to eq 'translated'
    end
  end
end
