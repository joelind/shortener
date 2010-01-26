class Url < ActiveRecord::Base
  validates_uniqueness_of :href, :case_sensitive => false
end
