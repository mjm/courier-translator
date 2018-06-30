RSpec.describe Courier::Translator do
  let(:input) { '' }
  subject { Courier::Translator.new(input) }
  let(:translated) { subject.translate }

  it 'has a version number' do
    expect(Courier::Translator::VERSION).not_to be nil
  end

  matcher :translate_to do |expected|
    match { |actual| actual.translate == expected }
  end

  context 'when the input is an empty string' do
    it 'translates an empty string' do
      should translate_to ''
    end
  end

  context 'when the input is a simple, unformatted string' do
    let(:input) { 'This is a very simple tweet.' }

    it 'translates to the input string' do
      should translate_to input
    end
  end

  context 'when the input has undesired HTML tags' do
    let(:input) { %(<p>This is also a simple tweet.</p>) }

    it 'strips the tags' do
      should translate_to 'This is also a simple tweet.'
    end
  end

  context 'when the input has multiple paragraphs' do
    let(:input) { %(<p>Paragraph 1</p><p>Paragraph 2</p>) }

    it 'adds a blank line between the paragraphs' do
      should translate_to %(Paragraph 1\n\nParagraph 2)
    end
  end

  context 'when the input has line break tags' do
    let(:input) { %(Some content<br>Some more content<br />This is it.) }

    it 'converts the tags to line breaks' do
      should translate_to %(Some content\nSome more content\nThis is it.)
    end
  end
end
