class Snippet < ActiveRecord::Base
  validates :name, :body, :presence => true
  validates :name, :uniqueness => true

  scope :published, lambda { where('created_at is not null').order('id desc') }
  scope :managed, lambda { order('id desc') }

  paginates_per 7
end
