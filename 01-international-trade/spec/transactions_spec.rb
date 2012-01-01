require_relative "../lib/transactions.rb"

describe Transactions do
  before do
    @transactions = Transactions.new("SAMPLE_TRANS.csv")
  end

  it "reads in data from a CSV file" do
    @transactions.data.class.should == CSV::Table
  end

  describe "#[]" do
    it "returns a hash with details of a transaction" do
      @transactions[0].should == { store: "Yonkers", sku: "DM1210", amount: "70.00", currency: "USD" }
    end
  end
end
