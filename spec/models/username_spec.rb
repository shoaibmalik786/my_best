require "spec_helper"

describe Username do
  context "with relations" do
    it { expect(subject).to belong_to(:user) }
    it { expect(subject).to belong_to(:business_profile) }
  end
  
  describe "#build_new_with_omniauth" do
    let(:data) { OmniAuth::AuthHash.new(
        uid: 1,
        info: {name: "Winnie The Poohić", first_name: "Boyo", last_name: "Moyo", email: "boyo@moyo.com", nickname: "boyo"}
    )}
    subject { described_class.build_new_with_omniauth(data) }

    it "just creates a new object" do
      expect(subject.new_record?).to be_true
    end

    it "defaults username to nickname if available" do
      expect(subject.username).to eq("boyo")
    end

    it "extracts username from full name" do
      data.info.stub(:nickname).and_return(nil)
      expect(subject.username).to eq("wpoohic")
    end

    it "does not build anything without omniauth data"  do
      expect(described_class.build_new_with_omniauth(nil)).to be_nil
    end
  end
end