require_relative './luhn_validator.rb'
require 'json'
require 'rbnacl/libsodium'
require 'openssl'

# Credit Card Class
class CreditCard
  include LuhnValidator

  # instance variables with automatic getter/setter methods
  attr_accessor :number, :expiration_date, :owner, :credit_network

  def initialize(number, expiration_date, owner, credit_network)
    self.number = number
    self.expiration_date = expiration_date
    self.owner = owner
    self.credit_network = credit_network
  end

  # returns json string
  def to_json
    {
      "number" => self.number,
      "expiration_date" => self.expiration_date,
      "owner" => self.owner,
      "credit_network" => self.credit_network

    }.to_json
  end

  # returns all card information as single string
  def to_s
    to_json
  end

  # return a new CreditCard object given a serialized (JSON) representation
  def self.from_s(card_s)
    # TODO: deserializing a CreditCard object
    data = JSON.parse(card_s)
    CreditCard.new(data.number, data.expiration_date, data.owner, data.credit_network)
  end

  # return a hash of the serialized credit card object
  def hash
    to_s.hash
  end

  # return a cryptographically secure hash
  def hash_secure
    OpenSSL::Digest::SHA256.digest(to_s)
  end
end
