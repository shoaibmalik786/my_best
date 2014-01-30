require "spec_helper"

describe BusinessProfileCategory do
  context "with relations" do
    it { expect(subject).to belong_to(:business_profile) }
    it { expect(subject).to belong_to(:business_category) }
  end

  context "category type" do
    it { expect(subject).to enumerize(:category_type).in(:primary, :secondary, :tertiary) }

    {primary: 1, secondary: 2, tertiary: 3}.each do |category_type, value|
      it "stores category type :#{category_type} as #{value}" do
        subject.category_type = category_type
        expect(subject.category_type_value).to eq(value)
      end
    end

    [:primary, :secondary, :tertiary].each do |category_type|
      it "defines a predicate for :#{category_type}" do
        subject.category_type = category_type
        expect(subject.send("#{category_type}?")).to eq(true)
      end
    end
  end
end