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

  context 'when the input has undesired HTML tags' do
    let(:input) { %(<p>This is also a simple tweet.</p>) }

    it 'strips the tags' do
      expect(translated).to eq 'This is also a simple tweet.'
    end
  end

  context 'when the input has multiple paragraphs' do
    let(:input) { %(<p>Paragraph 1</p><p>Paragraph 2</p>) }

    it 'adds a blank line between the paragraphs' do
      expect(translated).to eq %(Paragraph 1\n\nParagraph 2)
    end
  end
end
