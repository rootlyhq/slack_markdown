# encoding: utf-8

require 'html/pipeline'
require 'gemoji'

module SlackMarkdown
  module Filters
    class EmojiUtf8Filter < ::HTML::Pipeline::Filter

      def call
        doc.search('.//text()').each do |node|
          content = node.to_html
          # next if has_ancestor?(node, ignored_ancestor_tags)
          # next unless content.include?('`')
          html = emoji_filter(content)
          next if html == content
          node.replace(html)
        end
        doc
      end

      private

      def emoji_filter(text)
        text.gsub(EMOJI_PATTERN) do
          ::Emoji.find_by_alias($1)&.raw || text
        end
      end

      EMOJI_PATTERN = /:(\w+):/
    end
  end
end
