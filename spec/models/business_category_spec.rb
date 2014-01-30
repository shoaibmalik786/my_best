require "spec_helper"

describe BusinessCategory do
  context "with relations" do
    it { expect(subject).to have_many(:business_profile_categories) }
    it { expect(subject).to have_many(:business_profiles) }
  end

  context "with json representation" do
    subject { described_class.new(name: "Business", parent_id: 2) }

    it "prepares for typeahead" do
      subject.id = 100
      expect(subject.to_json).to be_json_eql(%({"id": 100, "name": "Business", "parent_id": 2}))
    end
  end
end