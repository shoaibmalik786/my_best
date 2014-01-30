shared_examples "time zone validator" do
  context "with time zone" do
    let(:time_zone_finder) { TimeZone }
    it { expect(subject).to respond_to(:time_zone) }
    it { expect(subject).to respond_to(:time_zone_name) }

    it "prefills time zone name from time zone" do
      time_zone_finder.should_receive(:find_by_code).with("UTC+2").and_return(double(name: "My Time Zone"))
      expect(subject.time_zone_name).to eq("My Time Zone")
    end

    it "rejects invalid time zone" do
      time_zone_finder.should_receive(:find_by_code).at_least(1).and_return(nil)
      subject.validate(empty_params.merge("time_zone" => "invalid"))
      expect(subject.errors[:time_zone]).not_to be_empty
    end

    it "allows valid time zone" do
      time_zone_finder.should_receive(:find_by_code).at_least(1).and_return(double)
      subject.validate(empty_params.merge("time_zone" => "valid"))
      expect(subject.errors[:time_zone]).to be_empty
    end
  end
end
