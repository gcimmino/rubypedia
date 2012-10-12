module Rubypedia
  class Crawler
    attr_reader :title, :lang, :fields, :body_page

    def initialize(title, fields, lang='en')
      @title      = title
      @lang       = lang
      @fields     = fields
      @body_page  = page_content
    end

    def page_content
      response = HTTParty.get resource_url, :headers => { 'User-Agent' => 'Httparty' }
      response.body
    end
    
    def resource_url(rvsection=0)
      "http://#{lang}.wikipedia.org/w/api.php?action=query&prop=revisions&titles=#{sanitize_title}&rvprop=content&format=json&rvsection=#{rvsection}"
    end
    
    def sanitize_title
      title.split.map(&:capitalize).join('_')
    end
    
    def get_content
      response_body = Rubypedia::ResponseBody.new(body_page)
      result = fields.inject Hash.new do |memo, field|
        memo.update response_body.hashify.select { |f,v| f == field }
      end
      result
    end

    def exists?(field)
      response_body = Rubypedia::ResponseBody.new(body_page)
      !!response_body.arrayfy.map { |e| e[0] == field }
    end
  end
end