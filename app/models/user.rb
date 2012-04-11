class User < ActiveRecord::Base

  include AccessLevels

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :access_level

  has_many :slices
  has_many :bills, :through => :slices

  def user?
    access_level >= USER
  end

  def admin?
    access_level >= ADMIN
  end

  def super_user?
    access_level >= SUPER_USER
  end
end
