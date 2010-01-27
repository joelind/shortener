require 'base_62_encoder' unless Object.const_defined?('Base62Encoder')

class Url < ActiveRecord::Base
  attr_accessible :href, :tag_list
  validates_presence_of :href
  validate :href_is_valid, :if => :href?

  has_many :tags

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

  def tag_list
    self.tags.map(&:text).join(', ')
  end

  def tag_list=(list)
    list_items = list.split(',').map(&:strip)
    self.tags.reject{|t| list_items.include? t.text}.map(&:destroy)
    (list_items - self.tags.map(&:text)).uniq.each do |new_tag_text|
      self.tags.build(:text => new_tag_text, :url => self)
    end
    self.tag_list
  end

  private
  def href_is_valid
    begin
      uri = URI.parse(self.href)
      self.errors.add(:href, "must be a valid url starting with 'http://' or 'https://'") unless ['http', 'https'].include?(uri.scheme)
    rescue URI::InvalidURIError => e
      self.errors.add(:href, "is invalid")
    end
  end
end
