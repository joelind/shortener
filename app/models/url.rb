require 'base_62_encoder' unless Object.const_defined?('Base62Encoder')

class Url < ActiveRecord::Base
  attr_accessible :href
  validates_uniqueness_of :href, :case_sensitive => false
  validates_presence_of :href
  validate :href_is_valid, :if => :href?

  def self.find_by_encoded_id(encoded_id)
    return nil if encoded_id.nil?

    find_by_id(encoder.decode(encoded_id))
  end

  def encoded_id
    Url.encoder.encode(self.id) if self.id.present?
  end

  def self.encoder
    ::Base62Encoder
  end

  def to_param
    encoded_id
  end

  private
  def href_is_valid
    begin
      uri = URI.parse(self.href)
      self.errors.add(:href, "is invalid") unless ['http', 'https'].include?(uri.scheme)
    rescue URI::InvalidURIError => e
      self.errors.add(:href, "is invalid")
    end
  end
end
