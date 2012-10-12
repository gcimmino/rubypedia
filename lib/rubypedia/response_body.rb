module Rubypedia
  class ResponseBody
    attr_reader :body

    def initialize(body)
      @body = body
    end
    
    def arrayfy
      result = []
      body.scan(/\|\s*(\w+)\s?=\s?\[*([\w\s\.\,\\]+)\]*/) do |field, value| 
        result << [field, value.gsub('\\n', '').strip]
      end
      result
      # /|\s*(\w+)\s*= \[\[(\w+)\]\]/ $1 key, $2 value.split('|').first 
      # %r{|\s*(\w+)\s*= [[(\w+)]]}
    end
    
    def hashify
      result = arrayfy.inject Hash.new do |memo, line|
        field, value = line
        memo.update(field => value)
      end
      result.delete_if { |field, value| field.nil? }
    end
    
    # def split_line(line)
    #   # a = line.split('=')
    #   # [ a[0].strip, a[1].split('|').first.gsub(/\[*\]*/, '').split(/<\w+\s*/).first.split('(').first.strip ] if a.size > 1
    # end
  end
end