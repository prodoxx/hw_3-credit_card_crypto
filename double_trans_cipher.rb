require 'matrix'

module DoubleTranspositionCipher
  def self.encrypt(document, key)
    # TODO: FILL THIS IN!
    ## Suggested steps for double transposition cipher
    # 1. find number of rows/cols such that matrix is almost square
    # 2. break plaintext into evenly sized blocks
    # 3. sort rows in predictibly random way using key as seed
    # 4. sort columns of each row in predictibly random way
    # 5. return joined cyphertext
    document = document.to_s
    row_col_size = Math.sqrt(document.size).ceil
    matrix = document.chars.to_a.each_slice(row_col_size).to_a
    matrix = matrix.map { |s| s.shuffle(random: Random.new(key)) }
    matrix.shuffle(random: Random.new(key)).join
  end

  def self.decrypt(ciphertext, key)
    row_col_size = Math.sqrt(ciphertext.size).ceil
    original_matrix = ciphertext.to_s.chars.to_a.each_slice(row_col_size).to_a
    new_matrix = []
    
    row_col_size.times do |n1|
      new_matrix[n1] = []
      row_col_size.times do |n2|
        new_matrix[n1][n2] = original_matrix[n2][n1] if !original_matrix[n2][n1].nil?
      end
    end

    print new_matrix

  end
end
