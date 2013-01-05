require 'redcarpet/compat'

class Post < ActiveRecord::Base
  SEPARATOR = '<!--more-->'

  attr_accessible :title, :tag_names, :published_at, :markdown

  belongs_to :user
  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings

  has_friendly_id :ascii_title, :use_slug => true

  validates :title, :published_at, :markdown, :presence => true
  validates :title, :uniqueness => true

  before_save :save_html

  scope :published, lambda { where('published_at <= ?', Time.now.utc).order('id desc') }
  scope :managed, lambda { order('id desc') }
  scope :recent, lambda { where('published_at <= ?', Time.now.utc).limit(5).order('id desc') }

  paginates_per 7

  def tag_names=(names)
    self.tags = Tag.with_names(names.strip.try(:split, ' '))
  end

  def tag_names
    tags.map(&:name).join(' ')
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
    if self.markdown =~ /(?<p>.*)#{SEPARATOR}(?<c>.*)/im
      self.preface = Markdown.new($~[:p]).to_html
      self.content = Markdown.new($~[:c]).to_html
    else
      self.content = Markdown.new(self.markdown).to_html
    end
  end
end
