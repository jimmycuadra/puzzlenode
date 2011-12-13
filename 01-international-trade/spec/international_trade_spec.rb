require_relative "../international_trade"

describe Conversions do
  before do
    @conversions = Conversions.new("SAMPLE_RATES.xml")
  end

  it "loads the XML document into a hash" do
    @conversions.data.should be_a Hash
  end

  it "determines all known currency types" do
    @conversions.types.should == ["AUD", "CAD", "USD"]
  end
end
