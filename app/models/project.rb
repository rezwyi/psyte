class Project < ActiveRecord::Base
  mount_uploader :screenshot, ScreenshotUploader

  validates :title, :description, :presence => true

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
