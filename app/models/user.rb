class User < ActiveRecord::Base
  has_many :posts

  def self.authenticate(login, password)
    user = find_by_login(login)
    hash_secret = BCrypt::Engine.hash_secret(password, user.password_salt)
    if user && user.password_hash == hash_secret
      user
    else
      nil
    end
  end
end
