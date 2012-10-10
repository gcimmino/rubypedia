require 'spec_helper'

fixture_path  = File.expand_path('../../fixtures', __FILE__)
poland        = File.read(fixture_path+"/poland")
england       = File.read(fixture_path+"/england")
warsaw        = File.read(fixture_path+"/warsaw")

describe Rubypedia do
  describe "#arrayfy" do
    it "return expected array from a string with newline and pipe as separators" do
      input = "conventional_long_name = Republic of Poland\\n|common_name = Poland"
      output = [ "conventional_long_name = Republic of Poland", "common_name = Poland" ]
      Rubypedia.arrayfy(input).should == output
    end
  end
  
  describe "#content" do
    it "return the string into square brackets" do
      input   = "leader_title2 = [[Prime Minister of the Republic of Poland|Prime Minister]]"
      output  = "Prime Minister of the Republic of Poland"
      Rubypedia.content(input).should == output
    end
  
    it "return value of a string not into square brackets" do
      input   = "conventional_long_name = Republic of Poland"
      output  = "Republic of Poland"
      Rubypedia.content(input).should == output
    end
    
    it "return value without ref tag" do
      input   = "currency = Turkish lira<ref>The Turkish lira (''T\u00fcrk Liras\u0131'', TL) replaced the Turkish lira#8th Emission group"
      output  = "Turkish lira"
      Rubypedia.content(input).should == output
    end
    
    it "return value for cities" do
      input   = 'population_total= 1,708,491<ref name=\"stat.gov.pl\">{{pl icon}} {{cite web|url=http:\/\/www.stat.gov.pl\/gus\/5840_13211_PLK_HTML.htm|title=Ludno\u015b\u0107 w gminach wed\u0142ug stanu w dniu 31.12.2011 r. bilans opracowany w oparciu o wyniki NSP\u20192011 |publisher=Gl\u00f3wny Urz\u0105d Statystyczny |date=|accessdate=21 August 2012}}<\/ref>\n|population_density_km2=3304\n|population_metro=2,666,278\n|population_density_metro_km2=631.4'
      output  = '1,708,491'
      Rubypedia.content(input).should == output
    end
  end
  
  describe "#response_body" do
    it "return page section 0 from wikipedia api" do
      title   = 'poland'
      Rubypedia.response_body(title).should == poland
    end
  end
  
  describe "#get_content" do
    it "return values of requested fields for poland" do
      Rubypedia.stub(:response_body => poland)
      title = "poland"
      lang = "en"
      fields = [
        "capital",
        "currency",
        "languages"
      ]
      output = { "capital" => 'Warsaw', "currency" => 'Polish z\u0142oty', "languages" => 'Polish language' }
      Rubypedia.get_content(title, lang, fields).should == output
    end
    
    it "return values of requested fields for warsaw" do
      Rubypedia.stub(:response_body => warsaw)
      title = "warsaw"
      lang = "en"
      fields = [
        "population_total",
        "area_total_km2"
      ]
      output = { "population_total" => '1,708,491', "area_total_km2" => '517.24' }
      Rubypedia.get_content(title, lang, fields).should == output
    end
  end
  
  describe "#hashify" do
    it "return an hash from array of values and an array of requests" do
      fields = [
          "capital",
          "currency",
          "languages"
        ]
        output = {
          "capital" => 'Warsaw',
          "currency" => 'Polish z\u0142oty',
          "languages" => 'Polish language'
        }
        Rubypedia.hashify(Rubypedia.arrayfy(poland), fields).should == output
    end
  end
  
  describe "#exists" do
    it "return true if a field exists" do
      Rubypedia.stub(:response_body => poland)
      title   = 'poland'
      lang    = 'en'
      field   = 'capital'
      output  = true
      Rubypedia.exists?(title, lang, field).should == output
    end    
  end
end