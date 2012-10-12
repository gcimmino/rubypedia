require 'spec_helper'

fixture_path  = File.expand_path('../../fixtures', __FILE__)
poland        = File.read(fixture_path+"/poland")
# england       = File.read(fixture_path+"/england")
# saudi_arabia  = File.read(fixture_path+"/saudi_arabia")
# warsaw        = File.read(fixture_path+"/warsaw")

describe "Crawler" do
  describe "#page_content" do
    it "return body of a wikipedia page" do
      crawler = Rubypedia::Crawler.new("poland", nil)
      crawler.page_content.should == poland
    end
  end
  
  describe "#sanitize_title" do
    it "return a string with capitalized words and spaces substituted by underscore" do
      title = "saudi arabia"
      crawler = Rubypedia::Crawler.new(title, nil)
      crawler.sanitize_title.should == "Saudi_Arabia"
    end
  end
  
  describe "#get_content" do
    it "return an hash with searched values" do
      title = "poland"
      fields = [ "capital" ]
      output = { "capital" => "Warsaw" }
      crawler = Rubypedia::Crawler.new(title, fields)
      crawler.get_content.should == output
    end
    
    it "return an hash with searched values, italian offcial_languages" do
      title = "italy"
      fields = [ "official_languages" ]
      output = { "official_languages" => "Italian language" }
      crawler = Rubypedia::Crawler.new(title, fields)
      crawler.get_content.should == output
    end
  end
  
  describe "#exists?" do
    it "return true if a field exists" do
      title = "italy"
      field = ["languages"]
      crawler = Rubypedia::Crawler.new(title, field)
      crawler.exists?(field).should be_true
    end
  end
end
