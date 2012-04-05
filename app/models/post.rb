class Post < ActiveRecord::Base
  SEPARATOR = '<!--more-->'

  belongs_to :user
  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings

  has_friendly_id :ascii_title, :use_slug => true

  validates :user_id, :title, :published_at, :markdown, :presence => true
  validates :title, :uniqueness => true

  before_save :save_html

  scope :published, lambda { where('published_at <= ?', Time.now.utc).order('id desc') }
  scope :managed, lambda { order('id desc') }
  scope :recent, lambda { where('published_at <= ?', Time.now.utc).limit(5).order('id desc') }

  paginates_per 7

  def tag_names=(names)
    self.tags = Tag.with_names(names.split(/\s+/))
  end

  def tag_names
    tag_names = tags.map(&:name).join(' ')
    tag_names += ' ' unless tag_names.blank?
  end

  protected

  def ascii_title
    arr = []
    self.title.split(' ').each do |word|
      arr << Russian::translit(word.downcase)
    end
    arr.join('-')
  end

  private

  def save_html
    if self.markdown =~ /(?<preface>.*)#{SEPARATOR}(?<content>.*)/im
      self.preface = RDiscount.new($~[:preface], :filter_html).to_html
      self.content = RDiscount.new($~[:content], :filter_html).to_html
    else
      self.content = RDiscount.new(self.markdown, :filter_html).to_html
    end
  end
end
