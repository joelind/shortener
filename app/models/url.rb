class Url < ActiveRecord::Base
  validates_uniqueness_of :href, :case_sensitive => false
  validates_presence_of :href
end
