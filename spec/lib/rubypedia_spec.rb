require 'spec_helper'

describe Rubypedia do
  describe "#get_content" do
    it "return values of requested fields for poland" do
      Rubypedia.stub :response_body => fixture_content('poland')
      opts = {
        :title  => "poland",
        :lang   => "en",
        :fields => [ "capital", "currency", "languages" ]
      }
      output = { "capital" => 'Warsaw', "currency" => 'Polish z\u0142oty', "languages" => 'Polish language' }
      Rubypedia.get_content(opts).should == output
    end

    it "return values of requested fields for italy" do
      opts = {
        :title  => 'italy',
        :lang   => "en",
        :fields => [ "capital", "currency", "official_languages" ]
      }
      output  = { "capital" => "Rome", "currency" => "Euro", "official_languages" => "Italian language" }
      Rubypedia.get_content(opts).should == output
    end

    it "return values of requested fields for warsaw" do
      Rubypedia.stub :response_body => fixture_content('warsaw')
      opts = {
        :title  => "warsaw",
        :lang   => "en",
        :fields => [ "population_total", "area_total_km2" ]
      }
      output = { "population_total" => '1,708,491', "area_total_km2" => '517.24' }
      Rubypedia.get_content(opts).should == output
    end
  end
end
