RSpec.describe Courier::Translator do
  let(:input) { '' }
  subject { Courier::Translator.new(input) }
  let(:translated) { subject.translate }

  it 'has a version number' do
    expect(Courier::Translator::VERSION).not_to be nil
  end

  matcher :translate_to do |expected|
    match do |actual|
      actual.translate == expected
    end

    failure_message do |actual|
      "expected #{actual.input.inspect} to translate to #{expected.inspect},\n but instead translated to #{actual.translate.inspect}"
    end
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
    let(:input) do
      %(<p>This is <strong>also</strong> a si<em>mp</em>le tweet.</p>)
    end

    it 'strips the tags' do
      should translate_to 'This is also a simple tweet.'
    end
  end

  context 'when the input has multiple paragraphs' do
    let(:input) do
      %(<p>Paragraph 1</p><p>Paragraph 2</p>)
    end

    it 'adds a blank line between the paragraphs' do
      should translate_to %(Paragraph 1\n\nParagraph 2)
    end
  end

  context 'when the input has line break tags' do
    let(:input) do
      %(Some content<br>Some more content<br />This is it.)
    end

    it 'converts the tags to line breaks' do
      should translate_to %(Some content\nSome more content\nThis is it.)
    end
  end

  context 'when the input has a link' do
    let(:input) do
      %(This is <a href="http://example.com/foo/bar">some #content.</a>)
    end

    it 'appends the URL at the end' do
      should translate_to %(This is some #content. http://example.com/foo/bar)
    end
  end

  context 'when the input has multiple links' do
    let(:input) do
      %(
        This is <a href="http://example.com/foo">some</a>
        <a href="http://example.com/bar">#content.</a>
      )
    end

    it 'appends each URL at the end in the order they appear' do
      should translate_to %(This is some #content. http://example.com/foo http://example.com/bar)
    end
  end

  context 'when the input has a block quote' do
    let(:input) do
      %(<p>Check this thing out:</p><blockquote>I said a thing</blockquote>)
    end

    it 'wraps the quote in quotation marks' do
      should translate_to %(Check this thing out:\n\n"I said a thing")
    end
  end

  context 'when the input has HTML entities' do
    let(:input) do
      %(<p>I&#8217;m having a &#8220;great time&#8221;. Here's
      &lt;strong&gt;some html&lt;/strong&gt;)
    end

    it 'unescapes the entities' do
      should translate_to "I’m having a “great time”. Here's <strong>some html</strong>"
    end
  end

  context 'when the input has a trailing newline after a paragraph' do
    let(:input) do
      "<p>This is some text</p>\n"
    end

    it 'strips the trailing space' do
      should translate_to 'This is some text'
    end
  end
end
