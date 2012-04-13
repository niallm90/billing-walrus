class User < ActiveRecord::Base
:A

  include AccessLevels

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :access_level, :name

  has_many :slices
  has_many :bills, :through => :slices

  before_save :default_values

  def verified?
    access_level >= VERIFIED
  end

  def admin?
    access_level >= ADMIN
  end

  def super_user?
    access_level >= SUPER_USER
  end

  private

  def default_values
    self.access_level ||= UNVERIFIED
  end
end
