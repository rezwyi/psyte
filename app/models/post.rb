class Post < ActiveRecord::Base
  belongs_to :user

  validates :title, :published_at, :body, presence: true
  validates :title, uniqueness: true

  scope :managed, -> { order('id desc') }
  scope :recent, -> do
    where('published_at <= ?', Time.now.utc).order('created_at desc')
  end

  def to_param
    "#{self.id}-#{self.title.to_slug.normalize(transliterations: [:russian, :latin]).to_s}"
  end
end