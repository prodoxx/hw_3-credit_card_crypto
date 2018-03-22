require_relative '../credit_card'
require_relative '../substitution_cipher'
require_relative '../double_trans_cipher'
require 'minitest/autorun'

def test_encryption(encryption, document, key, should_encrypt = true)
  should = should_encrypt ? 'should encrypt card information' : 'should decrypt text'
  it should do
    ed = should_encrypt ? encryption.encrypt(document,key) : encryption.decrypt(document, key)
    ed.wont_equal @cc.to_s
    ed.wont_be_nil
  end
end

describe 'Test card info encryption' do
  before do
    @cc = CreditCard.new('4916603231464963', 'Mar-30-2020', 'Soumya Ray', 'Visa')
    @key = 3
  end
  
  describe 'Using Caesar cipher' do
    test_encryption(SubstitutionCipher::Caesar, @cc, @key)
    test_encryption(SubstitutionCipher::Caesar, @cc, @key, false)
  end

  describe 'Using Permutation cipher' do
    test_encryption(SubstitutionCipher::Permutation, @cc, @key)
    test_encryption(SubstitutionCipher::Permutation, @cc, @key, false)
  end

  describe 'Using Double Transposition cipher' do
    test_encryption(DoubleTranspositionCipher, @cc, @key)
    test_encryption(DoubleTranspositionCipher, @cc, @key, false)
  end
end
