require_relative '../credit_card'
require_relative '../substitution_cipher'
require_relative '../double_trans_cipher'
require_relative '../sk_cipher'
require 'minitest/autorun'

def test_encryption(encryption, document, key, should_encrypt = true)
  should = should_encrypt ? 'should encrypt card information' : 'should decrypt text'
  it should do
    if should_encrypt
      ed = encryption.encrypt(document, key)
      ed.wont_be_nil
      ed.wont_equal document.to_s
    else
      en = encryption.encrypt(document, key)
      ed = encryption.decrypt(en, key)
      ed.wont_be_nil
      ed.must_equal document.to_s
    end
  end
end

cc = CreditCard.new('4916603231464963', 'Mar-30-2020', 'Soumya Ray', 'Visa')
key = 3
sk_cipher_key = ModernSymmetricCipher.generate_new_key

describe 'Test card info encryption' do

  describe 'Using Caesar cipher' do
    test_encryption(SubstitutionCipher::Caesar, cc, key)
    test_encryption(SubstitutionCipher::Caesar, cc, key, false)
  end

  describe 'Using Permutation cipher' do
    test_encryption(SubstitutionCipher::Permutation, cc, key)
    test_encryption(SubstitutionCipher::Permutation, cc, key, false)
  end

  describe 'Using Double Transposition cipher' do
    test_encryption(DoubleTranspositionCipher, cc, key)
    test_encryption(DoubleTranspositionCipher, cc, key, false)
  end

  describe 'Using Modern Symmetric Cipher' do
    test_encryption(ModernSymmetricCipher, cc, sk_cipher_key)
    test_encryption(ModernSymmetricCipher, cc, sk_cipher_key, false)
  end
end
