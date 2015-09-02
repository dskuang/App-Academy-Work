class User < ActiveRecord::Base

  before_validation :ensure_session_token

  has_many(
    :cats
  )

  has_many(
    :cat_rental_requests,
    foreign_key: :user_id,
    class_name: 'CatRentalRequest'
  )

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    if user && user.is_password?(password)
      user
    else
      nil
    end
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    session_token
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end



  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end



end
