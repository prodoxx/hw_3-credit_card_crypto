require 'rbnacl/libsodium'
require 'base64'

# Modern Symmetric Cipher
module ModernSymmetricCipher
  def self.generate_new_key
    Base64.strict_encode64(
      RbNaCl::Random.random_bytes(RbNaCl::SecretBox.key_bytes)
    )
  end

  def self.encrypt(document, key)
    simple_box = RbNaCl::SimpleBox.from_secret_key(Base64.strict_decode64(key))
    Base64.strict_encode64(simple_box.encrypt(document.to_s))
  end

  def self.decrypt(encrypted_cc, key)
    simple_box = RbNaCl::SimpleBox.from_secret_key(Base64.strict_decode64(key))
    simple_box.decrypt(Base64.strict_decode64(encrypted_cc))
  end
end
