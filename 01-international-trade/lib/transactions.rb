require "csv"
require "bigdecimal"

class Transactions
  attr_reader :data, :conversions

  def initialize(filename, conversions)
    @data = CSV.read("fixtures/#{filename}", headers: true, header_converters: :symbol)
    @conversions = conversions
  end

  def reduce_for_sku(sku)
    total = BigDecimal("0.00")

    @data.each do |row|
      next unless row[:sku] == sku

      amount, currency = row[:amount].split

      if currency == "USD"
        total += BigDecimal(amount)
      else
        total += conversions.convert(amount, currency, "USD")
      end
    end

    total.to_s("f")
  end
end
