require "spec_helper"

describe BusinessProfile do
  context "with relations" do
    it { expect(subject).to belong_to(:user) }
    it { expect(subject).to have_many(:business_profile_categories) }
    it { expect(subject).to have_many(:business_categories) }
    it { expect(subject).to have_one(:username) }
    it { expect(subject).to have_many(:messages) }
    it { expect(subject).to belong_to(:country) }
    it { expect(subject).to belong_to(:state) }
    it { expect(subject).to belong_to(:city) }
    it { expect(subject).to belong_to(:zip_code) }
  end

  context "#primary_business_category" do
  end
end
