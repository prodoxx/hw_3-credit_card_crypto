require_relative '../credit_card'
require 'minitest/autorun'


def test_hashing_consistency(cards, hashes, is_secure = false)
  describe 'Check hashes are consistently produced' do
    it 'Should check that the hash the card produce is not nil or empty' do
      cards_hashed = is_secure ? cards.map(&:hash_secure) : cards.map(&:hash)
      _(cards_hashed.include?(nil) || cards_hashed.include?('')).must_equal false
    end

    it 'Should produce the same hash repeatedly' do
      SHOULD_LOOP_X.times do
        cards_hashed = is_secure ? cards.map(&:hash_secure) : cards.map(&:hash)
        _(cards_hashed.include?(nil) || cards_hashed.include?('')).must_equal false
        hashes.must_equal cards_hashed
      end
    end
  end

  describe 'Check for unique hashes' do
    # TODO: Check that each card produces a different hash than other cards

    it 'Should check that the hash the card produce is not nil or empty' do
      cards_hashed = is_secure ? cards.map(&:hash_secure) : cards.map(&:hash)
      _(cards_hashed.include?(nil) || cards_hashed.include?('')).must_equal false
    end

    it 'Should should not produce the same hash as other cards' do
      SHOULD_LOOP_X.times do
        cards_hashed = is_secure ? cards.map(&:hash_secure) : cards.map(&:hash)
        _(cards_hashed.uniq.size).must_equal cards_hashed.size
      end
    end

  end
end

# Feel free to replace the contents of cards with data from your own yaml file
card_details = [
  { num: '4916603231464963',
    exp: 'Mar-30-2020',
    name: 'Soumya Ray',
    net: 'Visa' },
  { num: '6011580789725897',
    exp: 'Sep-30-2020',
    name: 'Nick Danks',
    net: 'Visa' },
  { num: '5423661657234057',
    exp: 'Feb-30-2020',
    name: 'Lee Chen',
    net: 'Mastercard' }
]

cards = card_details.map do |c|
  CreditCard.new(c[:num], c[:exp], c[:name], c[:net])
end

hashes = cards.map(&:hash)
secure_hashes = cards.map(&:hash_secure)

SHOULD_LOOP_X = 100

describe 'Test hashing requirements' do
  describe 'Test regular hashing' do
    test_hashing_consistency(cards, hashes)
  end

  describe 'Test cryptographic hashing' do
    

    describe 'Check regular hash not same as cryptographic hash' do
      test_hashing_consistency(cards, secure_hashes, true)
      # TODO: Check that each card's hash is different from its hash_secure
      it "should check that the card's hash is different from it's hash_secure" do
        cards_default_hash = cards.map(&:hash)
        cards_secure_hash = cards.map(&:hash_secure)

        _(cards_default_hash != cards_secure_hash).must_equal true
      end
    end
  end
end
