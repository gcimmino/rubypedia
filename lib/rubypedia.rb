require 'active_support/core_ext/hash'
require 'httparty'
require "rubypedia/version"
require "rubypedia/response_body"
require "rubypedia/crawler"

module Rubypedia
  extend self

  def get_content(options)
    options.reverse_merge!(default_options)
    title   = options[:title] unless validate_title(options[:title])
    lang    = options[:lang] unless validate_lang(options[:lang])
    fields  = options[:fields]
    Crawler.new(title, fields, lang).get_content
  end

  def default_options
    {:lang => :en}
  end
  
  def validate_title(title)
    if title.nil? || title.empty?
      raise ArgumentError, "Invalid title. Title must be a not empty string."
    end
  end
  
  def validate_lang(lang)
    if lang.empty?
      raise ArgumentError, "Invalid lang. Lang must be a not empty string."
    end
  end
end
