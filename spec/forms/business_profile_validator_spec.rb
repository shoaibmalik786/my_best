require "spec_helper"

describe BusinessProfileValidator do
  let(:record) { mock_model(Message) }
  let(:business_profile_finder) { BusinessProfile }
  let(:options) { {attributes: {business_profiles: double}} }
  subject { described_class.new(options, business_profile_finder) }

  it "requires business" do
    subject.validate_each(record, :business_profiles, nil)
    expect(record.errors.size).to eq(1)
    expect(record.errors.first[0]).to eq(:business_profiles)
    expect(record.errors.first[1]).to eq("can't be blank")
  end

  it "validates business against business list" do
    business_profile_finder.should_receive(:find_by_id).with("invalid").and_return(nil)
    subject.validate_each(record, :business_profiles, "invalid")
    expect(record.errors.size).to eq(1)
    expect(record.errors.first[0]).to eq(:business_profiles)
    expect(record.errors.first[1]).to eq("is invalid, choose one of your businesses")
  end

  it "allows business from business list" do
    business_profile_finder.should_receive(:find_by_id).with("valid").and_return(double)
    subject.validate_each(record, :business_profiles, "valid")
    expect(record.errors.size).to eq(0)
  end
end