require "spec_helper"

describe EmailValidator do
  let(:record) { mock_model(User) }
  let(:options) { {attributes: {email: double}} }
  subject { described_class.new(options) }

  it "does not allow invalid email" do
    subject.validate_each(record, :email, "not.?.valid_at_email.com")
    expect(record.errors.size).to eq(1)
    expect(record.errors.first[0]).to eq(:email)
    expect(record.errors.first[1]).to eq("is invalid")
  end

  it "allows valid email" do
    subject.validate_each(record, :email, "my.name@domain.com")
    expect(record.errors.size).to eq(0)
  end
end