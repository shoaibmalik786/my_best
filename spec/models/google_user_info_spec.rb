require "spec_helper"

describe GoogleUserInfo do
  it { expect(subject).to belong_to(:user) }

  describe "#build_new_with_omniauth" do
    let(:data) { OmniAuth::AuthHash.new(
        uid: 1,
        info: {image: "small.jpg"},
        extra: {raw_info: {link: "/johhnyq", gender: "male", birthday: "0000-04-01", locale: "en_US"}}
    )}
    subject { described_class.build_new_with_omniauth(data) }

    it "uses available information" do
      expect(subject.uid).to eq(1)

      expect(subject.image).to eq("small.jpg")

      expect(subject.profile).to eq("/johhnyq")
      expect(subject.gender).to eq("male")
      expect(subject.birthday).to eq("0000-04-01")
      expect(subject.locale).to eq("en_US")
    end

    it "just creates a new object" do
      expect(subject.new_record?).to be_true
    end

    it "does not build anything without omniauth data"  do
      expect(described_class.build_new_with_omniauth(nil)).to be_nil
    end
  end
end