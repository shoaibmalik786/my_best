require "spec_helper"

describe Message do
  context "with relations" do
    it { expect(subject).to belong_to(:business_profile) }
    it { expect(subject).to belong_to(:author) }
    it { expect(subject).to belong_to(:place) }
  end

  context "with message type" do
    it { expect(subject).to enumerize(:message_type).in(:social_incentive, :money_saving).with_default(:social_incentive) }

    {social_incentive: "S", money_saving: "M"}.each do |message_type, value|
      it "stores message type :#{message_type} as #{value}" do
        subject.message_type = message_type
        expect(subject.message_type_value).to eq(value)
      end
    end
  end

  context "with frequency" do
    it { expect(subject).to enumerize(:frequency).in(:daily, :weekly, :monthly) }

    {daily: "d", weekly: "w", monthly: "m"}.each do |frequency, value|
      it "stores frequency :#{frequency} as #{value}" do
        subject.frequency = frequency
        expect(subject.frequency_value).to eq(value)
      end
    end
  end

  context "with message status" do
    it { expect(subject).to enumerize(:message_status_id).in(:saved, :paused, :running, :stopped) }

    {saved: 1, paused: 2, running: 3, stopped: 4}.each do |message_status, value|
      it "stores message status :#{message_status} as #{value}" do
        subject.message_status_id = message_status
        expect(subject.message_status_id_value).to eq(value)
      end
    end
  end

  context "with message source" do
    it { expect(subject).to enumerize(:message_source_id).in(:user, :api, :crawler) }

    {user: 1, api: 2, crawler: 3}.each do |message_source, value|
      it "stores message source :#{message_source} as #{value}" do
        subject.message_source_id = message_source
        expect(subject.message_source_id_value).to eq(value)
      end
    end
  end
  context "with message action" do
    it { expect(subject).to enumerize(:action_button_id).in(:purchase, :rsvp, :donate, :claim) }

    {purchase: 1, rsvp: 2, donate: 3, claim: 4}.each do |message_action, value|
      it "stores message action :#{message_action} as #{value}" do
        subject.action_button_id = message_action
        expect(subject.action_button_id_value).to eq(value)
      end
    end
  end

  context "with title" do
    it "extracts from description" do
      subject.description = "bridge   over   troubled water \n  is    the worst song of all time definitely !!!"
      expect(subject.title).to eq("Bridge Over Troubled Water Is ...")
    end
  end
end