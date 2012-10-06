class Snippet < ActiveRecord::Base
  attr_accessible :name, :body

  validates :name, :body, :presence => true
  validates :name, :uniqueness => true

  scope :managed, lambda { order('id desc') }

  paginates_per 4
end
