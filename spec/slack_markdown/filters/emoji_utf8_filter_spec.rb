# encoding: utf-8
require 'spec_helper'

describe SlackMarkdown::Filters::EmojiUtf8Filter do
  subject do
    filter = SlackMarkdown::Filters::EmojiUtf8Filter.new(text)
    filter.call.to_s
  end

  context 'Hello :lollipop:' do
    let(:text) { 'Hello :lollipop:' }
    it { should eq 'Hello 🍭' }
  end
end
