require_relative "../lib/transactions.rb"

describe Transactions do
  before do
    @transactions = Transactions.new("SAMPLE_TRANS.csv", mock("Conversions"))
  end

  it "reads in data from a CSV file" do
    @transactions.data.class.should == CSV::Table
  end
end
