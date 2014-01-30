require "spec_helper"

describe CountryValidator do
  let(:record) { mock_model(UserAddress) }
  let(:country_finder) { Country }
  let(:options) { {attributes: {country: double}} }
  subject { described_class.new(options, country_finder) }

  it "allows blank country" do
    subject.validate_each(record, :country, nil)
    expect(record.errors.size).to eq(0)
  end

  it "validates country against country list" do
    country_finder.should_receive(:find_by_id).with("invalid").and_return(nil)
    subject.validate_each(record, :country, "invalid")
    expect(record.errors.size).to eq(1)
    expect(record.errors.first[0]).to eq(:country)
    expect(record.errors.first[1]).to eq("is invalid, use autocomplete to select")
  end

  it "allows country from country list" do
    country_finder.should_receive(:find_by_id).with("valid").and_return(double)
    subject.validate_each(record, :country, "valid")
    expect(record.errors.size).to eq(0)
  end
end