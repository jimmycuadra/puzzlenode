require "bigdecimal"

class Flights
  now = Time.new
  Year, Month, Day = now.year, now.month, now.day

  def initialize
    @flights = []
  end

  def <<(data)
    @flights << {
      from: data[0],
      to: data[1],
      departure: init_time(data[2]),
      arrival: init_time(data[3]),
      price: BigDecimal(data[4])
    }
  end

  def cheapest

  end

  def fastest

  end

  private

  def init_time(hours_minutes)
    hours, minutes = hours_minutes.split(":")
    Time.utc(Year, Month, Day, hours, minutes)
  end
end
