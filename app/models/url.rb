class Url < ActiveRecord::Base
  validates_uniqueness_of :href, :case_sensitive => false
  validates_presence_of :href
  validate :href_is_valid

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
