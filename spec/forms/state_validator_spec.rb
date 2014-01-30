require "spec_helper"

describe StateValidator do
  let(:record) { mock_model(UserAddress) }
  let(:state_finder) { State }
  let(:options) { {attributes: {state: double}} }
  subject { described_class.new(options, state_finder) }

  it "allows blank state" do
    subject.validate_each(record, :state, nil)
    expect(record.errors.size).to eq(0)
  end

  it "validates state against state list" do
    state_finder.should_receive(:find_by_id).with("invalid").and_return(nil)
    subject.validate_each(record, :state, "invalid")
    expect(record.errors.size).to eq(1)
    expect(record.errors.first[0]).to eq(:state)
    expect(record.errors.first[1]).to eq("is invalid, use autocomplete to select")
  end

  it "allows state from state list" do
    state_finder.should_receive(:find_by_id).with("valid").and_return(double)
    subject.validate_each(record, :state, "valid")
    expect(record.errors.size).to eq(0)
  end
end