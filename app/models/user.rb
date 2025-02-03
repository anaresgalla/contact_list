class User < ApplicationRecord
  has_secure_password
  before_save :email_downcase

  validates :name, presence: true, length: { maximum: 50 }
  validates :password, length: { minimum: 6 }
  validates :email, presence: true, length: { maximum: 255 },
                                    format: { with: URI::MailTo::EMAIL_REGEXP }, # Uses Rails' built-in RFC 5322-compliant regex for emails instead of manually set regex
                                    uniqueness: { case_sensitive: true }

  has_many :contacts, dependent: :destroy

  private
    def email_downcase
      self.email.downcase!
    end
end
