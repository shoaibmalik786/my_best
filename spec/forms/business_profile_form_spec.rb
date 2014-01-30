require "spec_helper"

describe BusinessProfileForm do
  let(:username) { mock_model(Username, {username: "pero"}).as_null_object }
  let(:address) { mock_model(UserAddress, {country: "HR"}).as_null_object }
  let(:business_profile_categories) { [] }
  let(:business_profile) { mock_model(BusinessProfile, {
      address: address, username: username, time_zone: "UTC+2",
      business_profile_categories: business_profile_categories,
      business_profile_facebook: mock_model(BusinessProfileFacebook).as_null_object,
      business_profile_google: mock_model(BusinessProfileGoogle).as_null_object,
      business_profile_twitter: mock_model(BusinessProfileTwitter).as_null_object
  }).as_null_object }
  let(:empty_params) { {
      "username_attributes" => {},
      "address_attributes" => {},
      "business_profile_categories_attributes" => {},
      "business_profile_facebook_attributes" => {},
      "business_profile_google_attributes" => {},
      "business_profile_twitter_attributes" => {}
  }}
  subject { described_class.new(business_profile) }

  it_should_behave_like "username validator"
  it_should_behave_like "time zone validator"
  #it_should_behave_like "address validator"

  context "with plain properties" do
    it { expect(subject).to respond_to(:name) }
    it { expect(subject).to respond_to(:contact) }
    it { expect(subject).to respond_to(:bio) }
    it { expect(subject).to respond_to(:email) }
    it { expect(subject).to respond_to(:phone) }
    it { expect(subject).to respond_to(:web) }
  end

  context "with category" do
    #let(:category_finder) { BusinessCategory }
    #it { expect(subject).to respond_to(:category_id) }
    #it { expect(subject).to respond_to(:category_name) }
    #
    #it "prefills category name from category id" do
    #  category_finder.should_receive(:find_by_id).with(1).and_return(double(name: "My Category"))
    #  expect(subject.category_name).to eq("My Category")
    #end
    #
    #it "rejects invalid category id" do
    #  category_finder.should_receive(:find_by_id).at_least(1).and_return(nil)
    #  subject.validate(empty_params.merge("category_id" => 2))
    #  expect(subject.errors[:category_id]).not_to be_empty
    #end
    #
    #it "allows valid category id" do
    #  category_finder.should_receive(:find_by_id).at_least(1).and_return(double)
    #  subject.validate(empty_params.merge("category_id" => 2))
    #  expect(subject.errors[:category_id]).to be_empty
    #end
  end
end
