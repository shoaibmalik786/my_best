require "spec_helper"

describe BusinessCategoryValidator do
  let(:record) { mock_model(BusinessProfile) }
  let(:category_finder) { BusinessCategory }
  let(:options) { {attributes: {category: double}} }
  subject { described_class.new(options, category_finder) }

  it "requires category" do
    subject.validate_each(record, :category, nil)
    expect(record.errors.size).to eq(1)
    expect(record.errors.first[0]).to eq(:category)
    expect(record.errors.first[1]).to eq("can't be blank")
  end

  it "validates category against category list" do
    category_finder.should_receive(:find_by_id).with("invalid").and_return(nil)
    subject.validate_each(record, :category, "invalid")
    expect(record.errors.size).to eq(1)
    expect(record.errors.first[0]).to eq(:category)
    expect(record.errors.first[1]).to eq("is invalid, use autocomplete to select")
  end

  it "allows category from category list" do
    category_finder.should_receive(:find_by_id).with("valid").and_return(double)
    subject.validate_each(record, :category, "valid")
    expect(record.errors.size).to eq(0)
  end
end