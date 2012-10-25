require 'spec_helper'

describe "ResponseBody" do
  describe "#hashify" do
    it 'returns an hash starting by an array of keys' do
      element  = ['calling_code', 'Telephone numbers in Poland']
      response = Rubypedia::ResponseBody.new fixture_content('poland')
      response.hashify.keys.should include(element[0])
    end
  end

  describe "#arrayfy" do
    it "#arrayfy" do
      element  = ['calling_code', 'Telephone numbers in Poland']
      response = Rubypedia::ResponseBody.new fixture_content('poland')
      response.arrayfy.should include(element)
    end

    it "includes an array with expected values for capital" do
      response_body = Rubypedia::ResponseBody.new fixture_content('poland')
      response_body.arrayfy.should include(["capital", "Warsaw"])
    end
  end
end
