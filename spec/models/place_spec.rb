require "spec_helper"

describe Place do
  context "with relations" do
    it { expect(subject).to have_many(:messages) }
  end
end