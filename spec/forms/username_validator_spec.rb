require "spec_helper"

describe UsernameValidator do
  let(:record) { mock_model(BusinessProfile) }
  let(:options) { {attributes: {username: double}} }
  subject { described_class.new(options) }

  it "requires username" do
    subject.validate_each(record, :username, nil)
    expect(record.errors.size).to eq(1)
    expect(record.errors.first[0]).to eq(:" ")
    expect(record.errors.first[1]).to eq("can't be blank")
  end

  %w(admin administrator superuser).each do |reserved|
    it "does not allow reserved name: #{reserved}" do
      subject.validate_each(record, :username, reserved)
      expect(record.errors.size).to eq(1)
      expect(record.errors.first[0]).to eq(:" ")
      expect(record.errors.first[1]).to eq("can't use reserved names")
    end
  end

  it "does not allow characters other than numbers and letters" do
    subject.validate_each(record, :username, "something?")
    expect(record.errors.size).to eq(1)
    expect(record.errors.first[0]).to eq(:" ")
    expect(record.errors.first[1]).to eq("can use only letters and numbers")
  end

  it "allows numbers and letters" do
    subject.validate_each(record, :username, "user1name2")
    expect(record.errors.size).to eq(0)
  end
end