class User < ActiveRecord::Base
  has_many :posts

  validates :login, :uniqueness => true

  def self.authenticate(login, password)
    return unless (user = self.find_by_login(login))
    hash_secret = BCrypt::Engine.hash_secret(password, user.password_salt)
    user && user.password_hash == hash_secret ? user : nil
  end
end
