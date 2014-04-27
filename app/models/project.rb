class Project < ActiveRecord::Base
  belongs_to :user

  validates :production_url, :description, presence: true

  scope :managed, -> { order('id desc') }
  scope :recent, -> { order('created_at desc') }
end
