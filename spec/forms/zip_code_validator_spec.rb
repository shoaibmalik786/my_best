require "spec_helper"

describe ZipCodeValidator do
  let(:record) { mock_model(UserAddress) }
  let(:zip_code_finder) { ZipCode }
  let(:options) { {attributes: {zip_code: double}} }
  subject { described_class.new(options, zip_code_finder) }

  it "allows blank zip_code" do
    subject.validate_each(record, :zip_code, nil)
    expect(record.errors.size).to eq(0)
  end

  it "validates zip_code against zip_code list" do
    zip_code_finder.should_receive(:find_by_id).with("invalid").and_return(nil)
    subject.validate_each(record, :zip_code, "invalid")
    expect(record.errors.size).to eq(1)
    expect(record.errors.first[0]).to eq(:zip_code)
    expect(record.errors.first[1]).to eq("is invalid, use autocomplete to select")
  end

  it "allows zip_code from zip_code list" do
    zip_code_finder.should_receive(:find_by_id).with("valid").and_return(double)
    subject.validate_each(record, :zip_code, "valid")
    expect(record.errors.size).to eq(0)
  end
end