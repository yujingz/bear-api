class User < ActiveRecord::Base
  before_create :generate_token

  has_secure_password

  has_many :ideas

  private

  def generate_token
    begin
      self.token = SecureRandom.hex
    end while self.class.exists?(token: token)
  end
end
