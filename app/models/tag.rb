class Tag < ActiveRecord::Base
  belongs_to :url
  validates_uniqueness_of :text, :scope => :url_id
  validates_presence_of :url
  validates_presence_of :text
end
