# Validates credit card number using Luhn Algorithm
module LuhnValidator
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)
    nums_a = nums_a.reverse_each.each_with_index.map do |n, k|
      next n unless k.odd?
      n *= 2
      n = n.to_s.chars.map(&:to_i).reduce(:+) if n > 9
      n
    end
    nums_a.reduce(:+).modulo(10).zero?
  end
end
