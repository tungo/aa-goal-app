class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  after_initalize :ensure_session_token!

  attr_reader :password

  def self.find_by_credentials(username, password)
    m_user = User.find_by(username: username)
    return nil unless m_user
    m_user.is_password?(password) ? m_user : nil
  end

  def password=(value)
    @password = value
    self.password_digest = BCrypt::Password.create(value)
  end

  def is_password?(value)
    BCrypt::Password.new(self.password_digest).is_password?(value)
  end

  def reset_session_token!
    self.session_token = generate_token
  end

  def ensure_session_token!
    self.session_token ||= generate_token
  end

  private

  def generate_token
    SecureRandom::urlsafe_base64(12)
  end

end
