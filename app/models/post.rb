class Post < ActiveRecord::Base
  Separator = '<!--more-->'

  cattr_reader :per_page
  @@per_page = 7

  belongs_to :user
  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings

  validates_presence_of :user_id, :title, :published_at, :markdown

  before_save :save_html

  scope :published, where('published_at <= ?', Time.now.utc).order('id desc')
  scope :managed, order('id desc')

  def tag_names=(names)
    self.tags = Tag.with_names(names.split(/\s+/))
  end

  def tag_names
    tag_names = tags.map(&:name).join(' ')
    tag_names += ' ' unless tag_names.blank?
  end

  private

  def save_html
    if self.markdown =~ /(?<preface>.*)#{Separator}(?<content>.*)/im
      self.preface = RDiscount.new($~[:preface], :filter_html).to_html
      self.content = RDiscount.new($~[:content], :filter_html).to_html
    else
      self.content = RDiscount.new(self.markdown, :filter_html).to_html
    end
  end

end
