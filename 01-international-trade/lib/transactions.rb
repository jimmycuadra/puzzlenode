require "csv"

class Transactions
  attr_reader :data

  def initialize(filename)
    @data = CSV.read("fixtures/#{filename}", headers: true, header_converters: :symbol)
  end

  def [](index)
    row = @data[index]
    amount, currency = row[:amount].split
    { store: row[:store], sku: row[:sku], amount: amount, currency: currency }
  end
end
