class Snippet < ActiveRecord::Base
  validates :name, :body, :presence => true
  validates :name, :uniqueness => true

  scope :managed, lambda { order('id desc') }

  paginates_per 4
end
