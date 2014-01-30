require "spec_helper"

describe TimeZone do
  context "as factory" do
    it { expect(described_class).to respond_to(:all) }
  end

  context "when finding a by code" do
    it "finds existing" do
      expect(described_class.find_by_code("Pacific/Pago_Pago").name).to eq("(GMT-11:00) American Samoa")
    end

    it "is case insensitive" do
      expect(described_class.find_by_code("pacific/pago_Pago").name).to eq("(GMT-11:00) American Samoa")
    end

    it "returns nil for no code" do
      expect(described_class.find_by_code(nil)).to be_nil
    end
  end

  context "with attributes" do
    subject { described_class.all.first }

    it { expect(subject.code).to eq("Pacific/Pago_Pago") }
    it { expect(subject.name).to eq("(GMT-11:00) American Samoa") }
  end
end