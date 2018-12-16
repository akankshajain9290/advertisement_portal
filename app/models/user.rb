class User < ApplicationRecord
  attr_accessor :password

  belongs_to :role
  has_many :adv_spaces, foreign_key: :provider_id
  has_many :slots, through: :adv_spaces
  has_many :pre_booked_slots, class_name: 'Slot', foreign_key: :agent_id
  has_many :booked_slots, class_name: 'Slot', foreign_key: :organiser_id
  has_many :bids

  before_save :init_encrypted_password
  after_save :clear_password

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP,
    message: "Not a valid email format" }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true


  def authenticate(user_password)
    self.encrypted_password == encrypt_password(user_password)
  end

  def self.find_by_email_or_username(username)
    find_by_email(username) || find_by_username(username)
  end

  def agent?
    self.role.agent?
  end

  def provider?
    self.role.provider?
  end

  def organiser?
    self.role.organiser?
  end

  def fullname
    "#{first_name.camelize} #{last_name.camelize}"
  end

  private

  def init_encrypted_password
    if password.present?
      self.encrypted_password = encrypt_password(password)
    end
  end

  def encrypt_password(user_password)
    Digest::SHA1.hexdigest(user_password)
  end

  def clear_password
    self.password = nil
  end

end
