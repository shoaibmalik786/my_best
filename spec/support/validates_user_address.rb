shared_examples "user address validator" do
  context "with address" do
    let(:user_address) { mock_model(UserAddress).as_null_object }

    it { expect(subject).to respond_to(:user_address) }

    context "with plain properties" do
      it { expect(subject.user_address).to respond_to(:address_one) }
      it { expect(subject.user_address).to respond_to(:address_two) }
    end

    context "with country" do
      let(:country_finder) { Country }
      it { expect(subject.user_address).to respond_to(:country_id) }
      it { expect(subject.user_address).to respond_to(:country_code) }
      it { expect(subject.user_address).to respond_to(:country_name) }

      it "prefills country name from country id" do
        user_address.should_receive(:country_id).and_return(100)
        country_finder.should_receive(:find_by_id).at_least(1).and_return(double(name: "My Country"))
        expect(subject.user_address.country_name).to eq("My Country")
      end

      it "prefills country code from country id" do
        user_address.should_receive(:country_id).and_return(100)
        country_finder.should_receive(:find_by_id).at_least(1).and_return(double(code: "II"))
        expect(subject.user_address.country_code).to eq("II")
      end

      it "rejects invalid country" do
        country_finder.should_receive(:find_by_id).at_least(1).and_return(nil)
        subject.validate(empty_params.merge("user_address_attributes" => {"country_id" => "invalid"}))
        expect(subject.errors["user_address.country_id"]).not_to be_empty
      end

      it "allows valid country" do
        country_finder.should_receive(:find_by_id).at_least(1).and_return(double)
        subject.validate(empty_params.merge("user_address_attributes" => {"country_id" => "valid"}))
        expect(subject.errors["user_address.country_id"]).to be_empty
      end
    end

    context "with state" do
      let(:state_finder) { State }
      it { expect(subject.user_address).to respond_to(:state_id) }
      it { expect(subject.user_address).to respond_to(:state_name) }

      it "prefills state name from state id" do
        user_address.should_receive(:state_id).and_return(100)
        state_finder.should_receive(:find_by_id).with(100).and_return(double(name: "My state"))
        expect(subject.user_address.state_name).to eq("My state")
      end

      it "rejects invalid state" do
        state_finder.should_receive(:find_by_id).at_least(1).and_return(nil)
        subject.validate(empty_params.merge("user_address_attributes" => {"state_id" => "invalid"}))
        expect(subject.errors["user_address.state_id"]).not_to be_empty
      end

      it "allows valid state" do
        state_finder.should_receive(:find_by_id).at_least(1).and_return(double)
        subject.validate(empty_params.merge("user_address_attributes" => {"state_id" => "valid"}))
        expect(subject.errors["user_address.state_id"]).to be_empty
      end
    end
    
    context "with city" do
      let(:city_finder) { City }
      it { expect(subject.user_address).to respond_to(:city_id) }
      it { expect(subject.user_address).to respond_to(:city_name) }

      it "prefills city name from city id" do
        user_address.should_receive(:city_id).and_return(100)
        city_finder.should_receive(:find_by_id).with(100).and_return(double(name: "My city"))
        expect(subject.user_address.city_name).to eq("My city")
      end

      it "rejects invalid city" do
        city_finder.should_receive(:find_by_id).at_least(1).and_return(nil)
        subject.validate(empty_params.merge("user_address_attributes" => {"city_id" => "invalid"}))
        expect(subject.errors["user_address.city_id"]).not_to be_empty
      end

      it "allows valid city" do
        city_finder.should_receive(:find_by_id).at_least(1).and_return(double)
        subject.validate(empty_params.merge("user_address_attributes" => {"city_id" => "valid"}))
        expect(subject.errors["user_address.city_id"]).to be_empty
      end
    end
    
    context "with zip code" do
      let(:zip_code_finder) { ZipCode }
      it { expect(subject.user_address).to respond_to(:zip_code_id) }
      it { expect(subject.user_address).to respond_to(:zip_code_name) }

      it "prefills zip_code name from zip_code id" do
        user_address.should_receive(:zip_code_id).and_return(100)
        zip_code_finder.should_receive(:find_by_id).with(100).and_return(double(name: "My zip_code"))
        expect(subject.user_address.zip_code_name).to eq("My zip_code")
      end

      it "rejects invalid zip_code" do
        zip_code_finder.should_receive(:find_by_id).at_least(1).and_return(nil)
        subject.validate(empty_params.merge("user_address_attributes" => {"zip_code_id" => "invalid"}))
        expect(subject.errors["user_address.zip_code_id"]).not_to be_empty
      end

      it "allows valid zip_code" do
        zip_code_finder.should_receive(:find_by_id).at_least(1).and_return(double)
        subject.validate(empty_params.merge("user_address_attributes" => {"zip_code_id" => "valid"}))
        expect(subject.errors["user_address.zip_code_id"]).to be_empty
      end
    end
  end
end
