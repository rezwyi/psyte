class Project < ActiveRecord::Base
  attr_accessible :production_url, :description

  validates :production_url, :description, :presence => true

  scope :active, -> { where('created_at is not null').order('id desc') }
  scope :managed, -> { order('id desc') }
  scope :recent, -> { order('created_at desc') }

  paginates_per 4
end
