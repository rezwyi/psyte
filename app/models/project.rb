class Project < ActiveRecord::Base
  attr_accessible :title, :image_url, :production_url, :source_url,
                  :description

  validates_presence_of :title, :description, :image_url
  has_friendly_id :ascii_title, :use_slug => true

  default_scope order('id desc')
  scope :managed, order('id desc')
  scope :recent, limit(5).order('id desc')

  private

  def ascii_title
    arr = []
    self.title.split(' ').each do |word|
      arr << Russian::translit(word.downcase)
    end
    arr.join('-')
  end
end
