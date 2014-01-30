require "spec_helper"

describe MessageForm do
  let(:message) { mock_model(Message).as_null_object }
  let(:empty_params) { {"place_attributes" => {}} }
  subject { described_class.new(message) }

  context "with plain properties" do
    it { expect(subject).to respond_to(:description) }
    it { expect(subject).to respond_to(:start_date) }
    it { expect(subject).to respond_to(:end_date) }
  end

  context "#message_type" do
    it { expect(subject).to enumerize(:message_type).in(:social_incentive, :money_saving) }

    it "rejects invalid message type" do
      subject.validate(empty_params.merge("message_type" => "invalid"))
      expect(subject.errors[:message_type]).not_to be_empty
    end

    ["S", "M", ""].each do |message_type|
      it "allows '#{message_type}' as valid message type" do
        subject.validate(empty_params.merge("message_type" => message_type))
        expect(subject.errors[:message_type]).to be_empty
      end
    end
  end

  context "#frequency" do
    it { expect(subject).to enumerize(:frequency).in(:daily, :weekly, :monthly) }

    it "rejects invalid frequency" do
      subject.validate(empty_params.merge("frequency" => "invalid"))
      expect(subject.errors[:frequency]).not_to be_empty
    end

    ["d", "w", "m", ""].each do |frequency|
      it "allows '#{frequency}' as valid frequency" do
        subject.validate(empty_params.merge("frequency" => frequency))
        expect(subject.errors[:frequency]).to be_empty
      end
    end
  end
end