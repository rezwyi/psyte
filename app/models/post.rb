class Post < ActiveRecord::Base
  attr_accessible :title, :published_at, :body

  belongs_to :user

  has_friendly_id :ascii_title, use_slug: true

  validates :title, :published_at, :body, presence: true
  validates :title, uniqueness: true

  scope :managed, -> { order('id desc') }
  scope :recent, -> do
    where('published_at <= ?', Time.now.utc).order('created_at desc')
  end

  protected

  def ascii_title
    arr = []
    self.title.split(' ').each do |word|
      arr << Russian::translit(word.downcase)
    end
    arr.join('-')
  end
end
