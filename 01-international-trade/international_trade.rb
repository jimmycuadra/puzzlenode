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
      conv = BigDecimal(rate["conversion"])

      @types << [from, to]

      @data[from] ||= {}
      @data[from][to] ||= conv
    end

    @types.flatten!.uniq!.sort!
  end

  def [](key)
    @data[key]
  end

  def fill_in_missing_conversions!
    missing_conversions.each do |from, missing_tos|
      missing_tos.each do |to|
        reverse = data[to][from]

        if !reverse.nil?
          data[from][to] = BigDecimal(1.to_s) / reverse
        else
          intermediate = find_intermediate_conversion(from, to)
          data[from][to] = data[from][intermediate] * data[intermediate][to]
        end
      end
    end
  end

  def convert(value, from, to)
    (BigDecimal(value.to_s) * data[from][to]).round(2, :banker)
  end

  private

  def missing_conversions
    missing = {}

    types.each do |from|
      missing[from] = types.reject { |to| from == to || data[from][to] }
    end

    missing
  end

  def find_intermediate_conversion(from, to)
    starting_keys = data[from].keys
    matching_key, unused = data.find { |key, value| starting_keys.include?(key) && data[key].keys.include?(to) }
    matching_key
  end
end
