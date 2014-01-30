require "spec_helper"

describe CityValidator do
  let(:record) { mock_model(UserAddress) }
  let(:city_finder) { City }
  let(:options) { {attributes: {city: double}} }
  subject { described_class.new(options, city_finder) }

  it "allows blank city" do
    subject.validate_each(record, :city, nil)
    expect(record.errors.size).to eq(0)
  end

  it "validates city against city list" do
    city_finder.should_receive(:find_by_id).with("invalid").and_return(nil)
    subject.validate_each(record, :city, "invalid")
    expect(record.errors.size).to eq(1)
    expect(record.errors.first[0]).to eq(:city)
    expect(record.errors.first[1]).to eq("is invalid, use autocomplete to select")
  end

  it "allows city from city list" do
    city_finder.should_receive(:find_by_id).with("valid").and_return(double)
    subject.validate_each(record, :city, "valid")
    expect(record.errors.size).to eq(0)
  end
end