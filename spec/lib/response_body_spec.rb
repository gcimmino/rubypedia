require 'spec_helper'

fixture_path  = File.expand_path('../../fixtures', __FILE__)
poland = File.read(fixture_path+"/poland")

describe "ResponseBody" do
  describe "#hashify" do
  end

  describe "#arrayfy" do
    it "#arrayfy" do
      element  = ['calling_code', 'Telephone numbers in Poland']
      response = Rubypedia::ResponseBody.new poland
      response.arrayfy.should include(element)
    end

    it "includes an array with expected values for capital" do
      response_body = Rubypedia::ResponseBody.new poland
      response_body.arrayfy.should include(["capital", "Warsaw"])
    end
  end
end