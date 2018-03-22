
# Double Transposition Cipher
module DoubleTranspositionCipher
  def self.encrypt(document, key)
    #
    document = document.to_s
    row_col_size = Math.sqrt(document.size).round
    matrix = document.chars.to_a.each_slice(row_col_size).to_a
    double_transposition_shuffle(matrix,key).join
  end

  def self.double_transposition_shuffle(matrix, key)
    matrix = matrix.shuffle(random: Random.new(key))
    matrix.map { |s| s.shuffle(random: Random.new(key)) }
  end

  def self.unshuffle(list, random:)
    shuffled_order = (0..(list.size - 1)).to_a.shuffle!(random: random)
    ordered_list = Array.new(list.size)
    shuffled_order.each_with_index { |val, i| ordered_list[val] = list[i] }
    ordered_list
  end

  def self.decrypt(ciphertext, key)
    row_col_size = Math.sqrt(ciphertext.size).round
    matrix = ciphertext.to_s.chars
    new_matrix = Array.new(ciphertext.size)

    digit_matrix = (0..(ciphertext.size - 1)).to_a.each_slice(row_col_size)
    digit_matrix = double_transposition_shuffle(digit_matrix.to_a, key).flatten
    digit_matrix.each_with_index { |v, i| new_matrix[v] = matrix[i] }
    new_matrix.join
  end
end
