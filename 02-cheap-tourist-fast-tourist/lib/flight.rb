require "bigdecimal"

class Flight
  attr_reader :from, :to

  Year, Month, Day = begin
    now = Time.new
    [now.year, now.month, now.day]
  end

  def initialize(from, to, departure, arrival, price)
    @from = from
    @to = to
    @departure = departure
    @arrival = arrival
    @price = price
  end

  def price
    BigDecimal(@price)
  end

  def departure
    init_time(@departure)
  end

  def arrival
    init_time(@arrival)
  end

  private

  def init_time(hours_minutes)
    hours, minutes = hours_minutes.split(":")
    Time.utc(Year, Month, Day, hours, minutes)
  end
end
