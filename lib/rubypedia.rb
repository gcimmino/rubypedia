require "rubypedia/version"
require 'httparty'
require 'pry'

module Rubypedia
  def self.get_content(title, lang, fields)
  	lines = arrayfy(response_body(title, lang))
    hashify(lines, fields)
  end
  
  def self.response_body(page, lang='en')
    url       = make_url(page, lang)
  	response  = HTTParty.get(url, :headers => { 'User-Agent' => 'Httparty' })
    response.body
  end
  
  def self.make_url(page, lang='en')
    if page.split.size > 1
      title = page.split.map(&:capitalize).join('_')
    else
      title = page.capitalize
    end
    "http://#{lang}.wikipedia.org/w/api.php?action=query&prop=revisions&titles=#{title}&rvprop=content&format=json&rvsection=0"
  end

  def self.hashify(lines, fields)
    result = Hash.new
    fields.each do |field|
      match = lines.detect {|line| line.match("#{field}\s*=") }
      if match
        result[field] = content(match)
      end
    end
    result
  end
  
  def self.arrayfy(response_body)
    response_body.split('\n|')
  end
    
  def self.content(line)
    a = line.split('=')
    a[1].split('|').first.gsub(/\[*\]*/, '').split(/<\w+\s*/).first.split(/\(/).first.strip
  end
  
  def self.exists?(title, lang='en', field)
    lines = arrayfy(response_body(title, lang))
    match = lines.detect { |line| line.match("#{field}\s*=") }
    match.nil? ? false : true
  end
end
