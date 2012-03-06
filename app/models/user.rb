class User < ActiveRecord::Base
  has_many :posts

  def self.authenticate(login, password)
    user = find_by_login(login)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
end
