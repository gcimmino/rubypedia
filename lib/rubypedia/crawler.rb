module Rubypedia
  class Crawler
    attr_reader :title, :lang, :fields

    def initialize(title, fields=[], lang='en')
      @title  = title
      @lang   = lang
      @fields = fields
    end

    def get_content
      fields.inject Hash.new do |memo, field|
        memo.update response_body.hashify.select {|f,v| f == field}
      end
    end

    def exists?(field)
      !!response_body.hashify.keys.index(field)
    end

    def title=(value)
      @title = value
      clear_response_body
    end

    def lang=(value)
      @lang = value
      clear_response_body
    end

    private

    def clear_response_body
      @response_body = nil
    end

    def page_content
      HTTParty.get(resource_url, :headers => {'User-Agent' => 'Httparty'}).body
    end

    def sanitize_title
      title.split.map(&:capitalize).join('_')
    end

    def response_body
      @response_body ||= Rubypedia::ResponseBody.new(page_content)
    end

    def resource_url(rvsection=0)
      "http://#{lang}.wikipedia.org/w/api.php?action=query&prop=revisions&titles=#{sanitize_title}&rvprop=content&format=json&rvsection=#{rvsection}"
    end
  end
end
