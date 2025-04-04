# encoding: utf-8

require 'html/pipeline'
require 'slack_markdown/filters/convert_filter'
require 'slack_markdown/filters/multiple_quote_filter'
require 'slack_markdown/filters/quote_filter'
require 'slack_markdown/filters/multiple_code_filter'
require 'slack_markdown/filters/code_filter'
# require 'slack_markdown/filters/emoji_filter'
require 'slack_markdown/filters/emoji_utf8_filter'
require 'slack_markdown/filters/bold_filter'
require 'slack_markdown/filters/italic_filter'
require 'slack_markdown/filters/line_break_filter'

module SlackMarkdown
  class Processor
    def initialize(context = {})
      @context = context
    end
    attr_reader :context

    def filters
      @filters ||= [
        SlackMarkdown::Filters::ConvertFilter, # must first run
        SlackMarkdown::Filters::MultipleQuoteFilter,
        SlackMarkdown::Filters::QuoteFilter,
        SlackMarkdown::Filters::EmojiUtf8Filter,
        SlackMarkdown::Filters::BoldFilter,
        SlackMarkdown::Filters::ItalicFilter,
      ]
    end

    def call(src_text, context = {}, result = nil)
      HTML::Pipeline.new(filters, self.context).call(src_text, context, result)
    end
  end
end
