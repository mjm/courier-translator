RSpec.describe Courier::Translator do
  let(:input) { '' }
  subject { Courier::Translator.new(input) }
  let(:translated) { subject.translate }

  it 'has a version number' do
    expect(Courier::Translator::VERSION).not_to be nil
  end

  context 'when the input is an empty string' do
    it 'translates an empty string' do
      expect(translated).to eq ''
    end
  end

  context 'when the input is a simple, unformatted string' do
    let(:input) { 'This is a very simple tweet.' }

    it 'translates to the input string' do
      expect(translated).to eq input
    end
  end
end
