module SubstitutionCipher
  # Caesar Encryption
  module Caesar
    BASE_ASCII = 32
    TOTAL_ASCII = 95
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      document.to_s.chars.map do |char|
        (((char.ord - BASE_ASCII) + key)
        .modulo(TOTAL_ASCII) + BASE_ASCII).chr
      end.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      document.to_s.chars.map do |char|
        (((char.ord - BASE_ASCII) - key)
        .modulo(TOTAL_ASCII) + BASE_ASCII).chr
      end.join
    end
  end

  # Permutation Encryption
  module Permutation
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using a permutation cipher
      random_dict = (0..127).to_a.shuffle(random: Random.new(key))
      document.to_s.chars.map(&:ord).map do |x|
        random_dict.find_index(x)
      end.pack('C*')
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher
      random_dict = (0..127).to_a.shuffle(random: Random.new(key))
      document.to_s.chars.map(&:ord).map { |x| random_dict[x] }.pack('C*')
    end
  end
end
