require "spec_helper"

describe UserProfileForm do
  let(:username) { mock_model(Username, {username: "pero"}).as_null_object }
  let(:user_address) { mock_model(UserAddress).as_null_object }
  let(:user) { mock_model(User, {user_address: user_address, username: username, time_zone: "UTC+2"}).as_null_object }
  let(:empty_params) { {"username_attributes" => {}, "user_address_attributes" => {}} }
  subject { described_class.new(user) }

  it_should_behave_like "username validator"
  it_should_behave_like "time zone validator"
  it_should_behave_like "user address validator"

  context "with plain properties" do
    it { expect(subject).to respond_to(:first_name) }
    it { expect(subject).to respond_to(:last_name) }
    it { expect(subject).to respond_to(:email) }
    it { expect(subject).to respond_to(:date_of_birth) }
    it { expect(subject).to respond_to(:bio) }
    it { expect(subject).to respond_to(:web) }
  end

  context "#gender" do
    it { expect(subject).to enumerize(:gender).in(:female, :male) }

    it "rejects invalid gender" do
      subject.validate(empty_params.merge("gender" => "invalid"))
      expect(subject.errors[:gender]).not_to be_empty
    end

    ["m", "f", ""].each do |gender|
      it "allows '#{gender}' as valid gender" do
        subject.validate(empty_params.merge("gender" => gender))
        expect(subject.errors[:gender]).to be_empty
      end
    end
  end
end