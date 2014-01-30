shared_examples "username validator" do
  context "with username" do
    it { expect(subject).to respond_to(:username) }

    context "with plain properties" do
      it { expect(subject.username).to respond_to(:username) }
    end

    context "with username" do
      # see ActiveRecord::Validations::UniquenessValidator#validate_each
      let(:username_finder) { Username }

      it "rejects duplicate username" do
        username_finder.stub_chain(:unscoped, :where).and_return(double(:exists? => true))
        subject.validate(empty_params.merge("username_attributes" => {"username" => "duplicate"}))
        expect(subject.errors["username.username"]).not_to be_empty
      end

      it "allows unique username" do
        username_finder.stub_chain(:unscoped, :where).and_return(double(:exists? => false))
        subject.validate(empty_params.merge("username_attributes" => {"username" => "unique"}))
        expect(subject.errors["username.username"]).to be_empty
      end
    end
  end
end
