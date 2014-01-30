require "spec_helper"

describe TimeZoneValidator do
  let(:record) { mock_model(User) }
  let(:time_zone_finder) { TimeZone }
  let(:options) { {attributes: {time_zone: double}} }
  subject { described_class.new(options, time_zone_finder) }

  it "allows blank time_zone" do
    subject.validate_each(record, :time_zone, nil)
    expect(record.errors.size).to eq(0)
  end

  it "validates time zone against time zone list" do
    time_zone_finder.should_receive(:find_by_code).with("invalid").and_return(nil)
    subject.validate_each(record, :time_zone, "invalid")
    expect(record.errors.size).to eq(1)
    expect(record.errors.first[0]).to eq(:time_zone)
    expect(record.errors.first[1]).to eq("is invalid, use autocomplete to select")
  end

  it "allows time zone from time zone list" do
    time_zone_finder.should_receive(:find_by_code).with("valid").and_return(double)
    subject.validate_each(record, :time_zone, "valid")
    expect(record.errors.size).to eq(0)
  end
end