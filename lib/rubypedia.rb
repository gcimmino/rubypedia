require 'httparty'
require 'pry'
require "rubypedia/version"
require "rubypedia/response_body"
require "rubypedia/crawler"


module Rubypedia
  def self.get_content(title, fields, lang='en')
    Crawler.new(title, fields, lang).get_content
  end
end
