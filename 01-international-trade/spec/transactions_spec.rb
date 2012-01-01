require_relative "../lib/transactions.rb"

describe Transactions do
  before do
    conversions = Conversions.new("SAMPLE_RATES.xml")
    @transactions = Transactions.new("SAMPLE_TRANS.csv", conversions)
  end

  it "reads in data from a CSV file" do
    @transactions.data.class.should == CSV::Table
  end

  describe "#reduce_for_sku" do
    it "finds the total sales for the given SKU in USD" do
      @transactions.reduce_for_sku("DM1182").should == "134.22"
    end
  end
end
