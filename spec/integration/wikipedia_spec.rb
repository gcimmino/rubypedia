require 'spec_helper'

module Rubypedia
  describe "Wikipedia integration" do
    def crawler(title, fields=[], lang='en')
      Crawler.new(title, fields, lang)
    end
  
    describe "#page_content" do
      it "returns body of the wikipedia page" do
        crawler("poland").send(:page_content).split("\n").should == fixture_content('poland').split("\n")
      end
    end
  end
end