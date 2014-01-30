require "spec_helper"

describe Country do
  context "with relations" do
    it { expect(subject).to have_many(:user_addresses) }
    it { expect(subject).to have_many(:states) }
    it { expect(subject).to have_many(:business_profiles) }
  end

  context "as factory" do
    it { expect(described_class).to respond_to(:all) }
  end

  context "with json representation" do
    subject { described_class.new(code: "HR", name: "Croatia") }

    it "prepares for typeahead" do
      subject.id = 100
      expect(subject.to_json).to be_json_eql(%({"id": 100, "code": "HR", "name": "Croatia", "tokens": ["HR", "Croatia"]}))
    end
  end
end