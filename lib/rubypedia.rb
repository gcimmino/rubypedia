require "rubypedia/version"
require 'httparty'
require 'pry'

module Rubypedia
  def self.get_content(title, lang, fields)
  	lines = arrayfy(response_body(title, lang))
    hashify(lines, fields)
  end
  
  def self.response_body(title, lang='en')
    url       = "http://#{lang}.wikipedia.org/w/api.php?action=query&prop=revisions&titles=#{title}&rvprop=content&format=json&rvsection=0"
  	response  = HTTParty.get(url, :headers => { 'User-Agent' => 'Httparty' })
    response.body
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
    if a.size == 2
      a[1].split('|').first.gsub(/\[*\]*/, '').split(/<ref\s*/).first.strip
    elsif a.size > 2
      if line.include?('<ref ')
        a[1].split('|').first.gsub(/\[*\]*/, '').split(/<ref\s*/).first.strip
      else
        raise "Unexpected line format"
      end
    end
  end
  
  def self.exists?(title, lang='en', field)
    lines = arrayfy(response_body(title, lang))
    match = lines.detect { |line| line.match("#{field}\s*=") }
    match.nil? ? false : true
  end
end
