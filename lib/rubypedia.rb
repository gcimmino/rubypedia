require 'active_support/core_ext/hash'
require 'httparty'
require "rubypedia/version"
require "rubypedia/response_body"
require "rubypedia/crawler"

module Rubypedia
  extend self

  def get_content(options)
    options.reverse_merge!(default_options)
    title  = options[:title]
    fields = options[:fields]
    lang   = options[:lang]
    Crawler.new(title, fields, lang).get_content
  end

  def default_options
    {:lang => :en, :fields => []}
  end
end
