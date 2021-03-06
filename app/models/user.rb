class User < ActiveRecord::Base

  attr_accessor :password
  before_save :encrypt_password
  before_create { generate_token(:auth_token) }

  validates_confirmation_of :password
  #validates_presence_of :password, :on => :update
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  has_many :items, foreign_key: "owner_id"
  has_one :picture, as: :imageable, dependent: :destroy
  has_many :addresses, dependent: :destroy

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def default_address
    self.addresses.select { |address| address.default}.first
  end

  def admin?
    self.admin
  end

  def display_name
    if self.name
      self.name
    else
      self.email
    end
  end
end
