require "spec_helper"

describe User do
  context "with relations" do
    it { expect(subject).to have_one(:twitter_user_info) }
    it { expect(subject).to have_one(:google_user_info) }
    it { expect(subject).to have_one(:facebook_user_info) }
    it { expect(subject).to have_one(:user_address) }
    it { expect(subject).to have_one(:username) }
    it { expect(subject).to have_many(:business_profiles) }
  end

  context "#has_business_profiles?" do
    let(:business_profiles) { mock_model(BusinessProfile) }

    before(:each) do
      subject.stub(:business_profiles).and_return(business_profiles)
    end

    it "is true when there are attached business profiles" do
      business_profiles.should_receive(:size).and_return(2)
      expect(subject.has_business_profiles?).to be_true
    end

    it "is false when there are no attached business profiles" do
      business_profiles.should_receive(:size).and_return(0)
      expect(subject.has_business_profiles?).to be_false
    end
  end
  
  describe "#name" do
    it "combines first and last name" do
      subject.stub(:first_name).and_return("Winnie")
      subject.stub(:last_name).and_return("The Pooh")
      expect(subject.name).to eq("Winnie The Pooh")
    end

    it "strips" do
      subject.stub(:first_name).and_return("  Winnie ")
      subject.stub(:last_name).and_return("   ")
      expect(subject.name).to eq("Winnie")
    end
  end

  describe "#title" do
    it "uses name if available" do
      subject.stub(:name).and_return("Winnie The Pooh")
      expect(subject.title).to eq("Winnie The Pooh")
    end

    it "uses email otherwise" do
      subject.stub(:name).and_return(" ")
      subject.stub(:email).and_return("winnie@lalaland.com")
      expect(subject.title).to eq("winnie@lalaland.com")
    end
  end

  describe "#short_title" do
    it "uses first name if available" do
      subject.stub(:first_name).and_return("Winnie")
      expect(subject.short_title).to eq("Winnie")
    end

    it "uses email otherwise" do
      subject.stub(:first_name).and_return(" ")
      subject.stub(:email).and_return("winnie@lalaland.com")
      expect(subject.short_title).to eq("Winnie")
    end
  end

  context "#gender" do
    it { expect(subject).to enumerize(:gender).in(:female, :male) }

    {female: "f", male: "m"}.each do |gender, value|
      it "stores gender :#{gender} as #{value}" do
        subject.gender = gender
        expect(subject.gender_value).to eq(value)
      end
    end
  end

  describe "#email_authenticated?" do
    context "without any omniauth user info" do
      it "is email authenticated" do
        [:twitter_user_info, :google_user_info, :facebook_user_info].each do |provider|
          subject.stub(provider).and_return(nil)
        end
        expect(subject.email_authenticated?).to be_true
      end
    end

    [:twitter_user_info, :google_user_info, :facebook_user_info].each do |provider|
      context "with #{provider} omniauth user info" do
        it "is not email authenticated" do
          subject.stub(provider).and_return(double)
          expect(subject.email_authenticated?).to be_false
        end
      end
    end
  end

  describe "#build_new_with_omniauth" do
    let(:data) { OmniAuth::AuthHash.new(
        uid: 1,
        info: {name: "Winnie The Poohić", first_name: "Boyo", last_name: "Moyo", email: "boyo@moyo.com", nickname: "boyo"}
    )}
    subject { described_class.build_new_with_omniauth(data) }

    it "uses available information" do
      expect(subject.first_name).to eq("Boyo")
      expect(subject.last_name).to eq("Moyo")
      expect(subject.email).to eq("boyo@moyo.com")
    end

    it "just creates a new object" do
      expect(subject.new_record?).to be_true
    end

    it "extracts first name from full name" do
      data.info.stub(:first_name).and_return(nil)
      expect(subject.first_name).to eq("Winnie")
    end

    it "extracts last name from full name" do
      data.info.stub(:last_name).and_return(nil)
      expect(subject.last_name).to eq("The Poohić")
    end

    it "does not build anything without omniauth data"  do
      expect(described_class.build_new_with_omniauth(nil)).to be_nil
    end
  end

  describe "Devise::Validatable workaround" do
    context "when email authenticated" do
      before(:each) { subject.stub(:email_authenticated?).and_return(true) }

      it "requires password" do
        expect(subject.password_required?).to be_true
      end

      it "requires email" do
        expect(subject.email_required?).to be_true
      end
    end

    context "when not email authenticated" do
      before(:each) { subject.stub(:email_authenticated?).and_return(false) }

      context "with blank password" do
        it "allows it" do
          subject.stub(:password).and_return("  ")
          expect(subject.password_required?).to be_false
        end
      end

      context "with blank email" do
        it "allows it" do
          subject.stub(:email).and_return("  ")
          expect(subject.email_required?).to be_false
        end
      end
    end
  end
end