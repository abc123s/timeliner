class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_many :timelines
  has_secure_password

  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validates :name, presence: true, length: { within: 4..50 }, uniqueness: true
  validates :email, presence: true, uniqueness: true

  before_save :create_remember_token

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

end
