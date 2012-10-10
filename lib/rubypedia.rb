require "rubypedia/version"
require 'httparty'
require 'pry'

module Rubypedia
  def self.get_content(title, lang, fields)
    Crawler.new(title, lang, fields).get_content
  end

  class Crawler
    attr_reader :title, :lang, :fields

    def initialize(title, lang, fields)
      @title  = title
      @lang   = lang
      @fields = fields
    end

    def get_content
      hashify(arrayfy(response_body))
    end

    def exists?(field)
      arrayfy(response_body).detect { |line| line.match("#{field}\s*=") } || false
    end

    private

    def arrayfy(response_body)
      response_body.split('\n|')
    end

    def response_body
      response = HTTParty.get resource_url, :headers => { 'User-Agent' => 'Httparty' }
      response.body
    end

    def resource_url(rvsection=0)
      "http://#{lang}.wikipedia.org/w/api.php?action=query&prop=revisions&titles=#{sanitized_title}&rvprop=content&format=json&rvsection=#{rvsection}"
    end

    def sanitized_title
      title.split.map(&:capitalize).join('_')
    end

    def hashify(lines)
      fields.inject Hash.new do |result, field|
        match = lines.detect {|line| line.match("#{field}\s*=") }
        result[field] = content(match) if match
        result
      end
    end

    def content(line)
      a = line.split('=')
      a[1].split('|').first.gsub(/\[*\]*/, '').split(/<\w+\s*/).first.split('(').first.strip
    end
  end
end
