class FlightSet
  def initialize
    @flights = []
  end

  def <<(flight)
    @flights << flight
    compute_paths
  end

  def cheapest
  end

  def fastest
  end

  private

  def compute_paths
    @flights.select { |flight| flight.from == "A" }.each do |flight|
      puts flight
    end
  end
end
