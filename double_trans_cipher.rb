
# Double Transposition Cipher
module DoubleTranspositionCipher
  def self.encrypt(document, key)
    matrix = create_matrix(document.to_s.chars)
    double_transposition_shuffle(matrix, key).join
  end

  def self.double_transposition_shuffle(matrix, key)
    key = key.to_s.bytes.reduce(&:*)
    matrix = matrix.shuffle(random: Random.new(key))
    matrix.map { |s| s.shuffle(random: Random.new(key)) }
  end

  def self.unshuffle(list, random:)
    shuffled_order = (0..(list.size - 1)).to_a.shuffle(random: random)
    ordered_list = Array.new(list.size)
    shuffled_order.each_with_index { |val, i| ordered_list[val] = list[i] }
    ordered_list
  end

  def self.create_matrix(list)
    row_col_size = Math.sqrt(list.size).round
    list.each_slice(row_col_size).to_a
  end

  def self.transpose_list(order, list)
    new_list = Array.new(list.size)
    order.each_with_index { |v, i| new_list[v] = list[i] }
    new_list
  end

  def self.decrypt(ciphertext, key)
    digit_matrix = double_transposition_shuffle(
      create_matrix((0..(ciphertext.size - 1)).to_a), key
    ).flatten
    transpose_list(digit_matrix, ciphertext.to_s.chars).join
  end
end
