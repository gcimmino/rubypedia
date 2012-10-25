require 'spec_helper'

module Rubypedia
  describe Crawler do
    def crawler(title, fields=[], lang='en')
      Crawler.new(title, fields, lang)
    end
    
    describe "#get_content" do
      it "returns a hash with requested values" do
        crawler('poland', ['capital']).get_content.should == { "capital" => "Warsaw" }
      end

      it "returns a hash with requested values also on italy page" do
        crawler("italy", ["official_languages"]).get_content.should == { "official_languages" => "Italian language" }
      end
    end

    describe "#exists?" do
      let(:title) {'italy'}
      
      context 'when requested field exists' do        
        it "returns true" do
          fields = ["official_languages"]
          crawler(title, fields).exists?(fields.first).should be_true
        end
      end

      context 'when field doesnt exist' do
        it 'returns false' do
          fields = ["abracadabra"]
          crawler(title, fields).exists?(fields.first).should be_false
        end
      end
    end

    describe 'private methods' do
      describe "#sanitize_title" do
        it "return a string with capitalized words and spaces substituted by underscore" do
          crawler("saudi arabia").send(:sanitize_title).should == "Saudi_Arabia"
        end
      end
    end
  end
end