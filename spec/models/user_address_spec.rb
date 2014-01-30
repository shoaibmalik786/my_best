require "spec_helper"

describe UserAddress do
  context "with relations" do
    it { expect(subject).to belong_to(:user) }
    it { expect(subject).to belong_to(:country) }
  end
end