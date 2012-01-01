require "csv"

class Transactions
  attr_reader :data

  def initialize(filename)
    @data = CSV.read("fixtures/#{filename}", headers: true, header_converters: :symbol)
  end
end
