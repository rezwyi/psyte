class Post < ActiveRecord::Base
  SEPARATOR = '<!--more-->'

  attr_accessible :title, :markdown, :published_at, :tag_names

  belongs_to :user
  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings

  has_friendly_id :ascii_title, :use_slug => true

  validates_presence_of :user_id, :title, :published_at, :markdown
  validates_uniqueness_of :title

  before_save :save_html

  scope :published, where('published_at <= ?', Time.now.utc).order('id desc')
  scope :managed, order('id desc')
  scope :recent, where('published_at <= ?', Time.now.utc).limit(5).order('id desc')

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
