# Validates credit card number using Luhn Algorithm
module LuhnValidator
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    number.to_s.chars.map(&:to_i).reverse_each.each_with_index.map do |n, k|
      next n unless k.odd?
      luhn_calculation(n)
    end.reduce(:+).modulo(10).zero?
  end

  def luhn_calculation(n)
    n *= 2
    n = n.to_s.chars.map(&:to_i).reduce(:+) if n > 9
    n
  end
end
