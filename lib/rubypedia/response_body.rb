module Rubypedia
  class ResponseBody
    attr_reader :body

    NASTY_REGEXP = /\|\s*(\w+)\s?=\s?\[*([\w\s\.,\\]+)\]*/

    def initialize(body)
      @body = body
    end

    def arrayfy
      [].tap do |array|
        body.scan NASTY_REGEXP do |field, value|
          array << [field, value.gsub('\\n', '').strip]
        end
      end
    end

    def hashify
      res = arrayfy.inject Hash.new do |memo, line|
        field, value = line
        memo.update(field => value)
      end
      res
    end
  end
end
