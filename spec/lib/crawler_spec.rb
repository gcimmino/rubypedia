require 'spec_helper'

describe "Crawler" do
  describe "#get_content" do
    it "returns a hash with requested values" do
      title = "poland"
      fields = [ "capital" ]
      crawler = Rubypedia::Crawler.new(title, fields)
      crawler.get_content.should == { "capital" => "Warsaw" }
    end

    it "returns a hash with requested values also on italy page" do
      title = "italy"
      fields = [ "official_languages" ]
      crawler = Rubypedia::Crawler.new(title, fields)
      crawler.get_content.should == { "official_languages" => "Italian language" }
    end
  end

  describe "#exists?" do
    context 'when requested field exists' do
      it "returns true" do
        title = "italy"
        fields = ["official_languages"]
        crawler = Rubypedia::Crawler.new(title, fields)
        crawler.exists?(fields.first).should be_true
      end
    end

    context 'when field doesnt exist' do
      it 'returns false' do
        title = "italy"
        fields = ["abracadabra"]
        crawler = Rubypedia::Crawler.new(title, fields)
        crawler.exists?(fields.first).should be_false
      end
    end
  end

  describe 'private methods' do
    describe "#page_content" do
      it "returns body of the wikipedia page" do
        crawler = Rubypedia::Crawler.new("poland")
        crawler.send(:page_content).should == fixture_content('poland')
      end
    end

    describe "#sanitize_title" do
      it "return a string with capitalized words and spaces substituted by underscore" do
        crawler = Rubypedia::Crawler.new("saudi arabia")
        crawler.send(:sanitize_title).should == "Saudi_Arabia"
      end
    end
  end
end
