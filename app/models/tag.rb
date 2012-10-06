class Tag < ActiveRecord::Base
  attr_accessible :name

  has_many :taggings, :dependent => :destroy
  has_many :posts, :through => :taggings
  
  validates :name, :presence => true

  scope :active, lambda { where('created_at is not null').order('id desc') }
  scope :managed, lambda { order('id desc') }

  paginates_per 4

  def self.with_names(names)
    names.map do |name|
      Tag.find_or_create_by_name(name)
    end
  end
end
