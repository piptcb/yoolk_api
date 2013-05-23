require 'spec_helper'

describe 'Portal' do
  before(:all) do
    YoolkApi.setup(
      domain_name: 'yellowpages-cambodia.dev:3000'
    )
  end

  context "Methods" do
    it "should not have method find" do
      YoolkApi::Portal.methods.should_not include(:find)
    end

    it "should return currency_code" do
      portal = YoolkApi::Portal.current

      portal.currency_code.should == 'USD'
    end
  end
end