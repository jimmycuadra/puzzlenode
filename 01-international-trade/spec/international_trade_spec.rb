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

  it "determines known conversions" do
    @conversions["AUD"]["CAD"].should == 1.0079
    @conversions["CAD"]["USD"].should == 1.0090
    @conversions["USD"]["CAD"].should == 0.9911
  end
end
