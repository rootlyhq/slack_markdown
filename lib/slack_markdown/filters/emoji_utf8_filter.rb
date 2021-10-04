# encoding: utf-8

require 'html/pipeline'
require 'slack_markdown/filters/ignorable_ancestor_tags'
require 'gemoji'

module SlackMarkdown
  module Filters
    class EmojiUtf8Filter < ::HTML::Pipeline::Filter
      include IgnorableAncestorTags

      def call
        doc.search('.//text()').each do |node|
          content = node.to_html
          next if has_ancestor?(node, ignored_ancestor_tags)
          next unless content.include?(':')
          html = emoji_filter(content)
          next if html == content
          node.replace(html)
        end
        doc
      end

      private

      def emoji_filter(text)
        text.gsub(EMOJI_PATTERN) do
          ::Emoji.find_by_alias($1)&.raw
        end
      end

      EMOJI_PATTERN = /(?<=^|\W):(.+?):(?=\W|$)/
    end
  end
end
