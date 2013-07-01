class Project < ActiveRecord::Base
  attr_accessible :production_url, :description

  validates :production_url, :description, :presence => true

  scope :managed, -> { order('id desc') }
  scope :recent, -> { order('created_at desc') }
end
