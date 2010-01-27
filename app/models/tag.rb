class Tag < ActiveRecord::Base
  belongs_to :url
  validates_uniqueness_of :text, :scope => :url_id
  validates_presence_of :url
  validates_presence_of :text

  named_scope :having_text_like, lambda{|text|
    {
      :conditions => ["upper(text) like upper(?)", "%#{text}%"]
    }
  }
  named_scope :text_only, { :select => 'text' }
end
