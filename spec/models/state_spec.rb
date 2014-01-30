require "spec_helper"

describe State do
  context "with relations" do
    it { expect(subject).to belong_to(:country) }
    it { expect(subject).to have_many(:user_addresses) }
    it { expect(subject).to have_many(:business_profiles) }
  end

  context "as factory" do
    it { expect(described_class).to respond_to(:all) }
  end

  context "with json representation" do
    let(:country) { mock_model(Country, id: 200, code: "HR", name: "Croatia") }
    subject { described_class.new(name: "Istra") }

    it "prepares for typeahead" do
      subject.id = 100
      subject.country = country
      expect(subject.to_json).to be_json_eql(%({"id": 100, "name": "Istra", "tokens": ["Istra", "HR", "Croatia"]}))
    end
  end
end