class Project < ActiveRecord::Base
  validates_presence_of :title, :description, :image_url
  has_friendly_id :ascii_title, :use_slug => true

  scope :active, lambda { where('created_at is not null').order('id desc') }
  scope :managed, lambda { order('id desc') }
  scope :recent, lambda { limit(5).order('id desc') }

  paginates_per 4

  private

  def ascii_title
    arr = []
    self.title.split(' ').each do |word|
      arr << Russian::translit(word.downcase)
    end
    arr.join('-').html_safe
  end
end
