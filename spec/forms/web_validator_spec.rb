require "spec_helper"

describe WebValidator do
  let(:record) { mock_model(User) }
  let(:options) { {attributes: {web: double}} }
  subject { described_class.new(options) }

  it "does not allow invalid web" do
    subject.validate_each(record, :web, "s://domain.com")
    expect(record.errors.size).to eq(1)
    expect(record.errors.first[0]).to eq(:web)
    expect(record.errors.first[1]).to eq("is invalid")
  end

  it "allows web with full url" do
    subject.validate_each(record, :web, "http://domain.com")
    expect(record.errors.size).to eq(0)
  end

  it "allows web with https url" do
    subject.validate_each(record, :web, "https://domain.com")
    expect(record.errors.size).to eq(0)
  end

  it "allows web with partial url" do
    subject.validate_each(record, :web, "domain.com")
    expect(record.errors.size).to eq(0)
  end
end