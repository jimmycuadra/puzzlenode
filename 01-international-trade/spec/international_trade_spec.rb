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

  describe "#[]" do
    it "provides access to individual conversion rates" do
      @conversions["AUD"]["CAD"].should == 1.0079
    end
  end

  describe "#missing_conversions" do
    it "determines missing conversions" do
      @conversions.send(:missing_conversions).should == { "AUD" => ["USD"], "CAD" => ["AUD"], "USD" => ["AUD"] }
    end
  end

  describe "#convert" do
    it "converts a value from one rate to another" do
      @conversions.send(:convert, 10.25, "AUD", "CAD").to_s("F").should == "10.33"
    end
  end

  describe "#fill_in_missing_conversions!" do
    it "fills in conversions that are the reverse of a known conversion" do
      @conversions.fill_in_missing_conversions!
      @conversions["CAD"]["AUD"].to_s("F").should == "0.992161920825478718126798294"
    end

    it "fills in conversions that require an intermediate conversion" do
      @conversions.fill_in_missing_conversions!
      @conversions["AUD"]["USD"].should == 1.0169711
    end
  end
end
