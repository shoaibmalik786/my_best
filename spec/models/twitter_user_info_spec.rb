require "spec_helper"

describe TwitterUserInfo do
  it { expect(subject).to belong_to(:user) }

  describe "#build_new_with_omniauth" do
    let(:data) { OmniAuth::AuthHash.new(
        uid: 1,
        info: {image: "small.jpg", location: "NY"},
        extra: {raw_info: {geo_enabled: true, time_zone: "NY", utc_offset: -3600}}
    )}
    subject { described_class.build_new_with_omniauth(data) }

    it "uses available information" do
      expect(subject.uid).to eq(1)

      expect(subject.image).to eq("small.jpg")
      expect(subject.location).to eq("NY")

      expect(subject.geo_enabled).to be_true
      expect(subject.time_zone).to eq("NY")
      expect(subject.utc_offset).to eq(-3600)
    end

    it "just creates a new object" do
      expect(subject.new_record?).to be_true
    end

    it "does not build anything without omniauth data"  do
      expect(described_class.build_new_with_omniauth(nil)).to be_nil
    end
  end
end