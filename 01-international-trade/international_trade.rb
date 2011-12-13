require "active_support/core_ext/hash"
require "bigdecimal"

class Conversions
  attr_reader :data, :types

  def initialize(filename)
    @data = {}
    @types = []

    @raw = Hash.from_xml(File.read("files/#{filename}"))


    @raw["rates"]["rate"].each do |rate|
      from = rate["from"]
      to = rate["to"]
      conv = BigDecimal.new(rate["conversion"])

      @types << [from, to]

      @data[from] ||= {}
      @data[from][to] ||= conv
    end

    @types.flatten!.uniq!.sort!
  end

  def [](key)
    @data[key]
  end

  def missing_conversions
    missing = {}

    types.each do |from|
      missing[from] = types.reject { |to| from == to || data[from][to] }
    end

    missing
  end
end
