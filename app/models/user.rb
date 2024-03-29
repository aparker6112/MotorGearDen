class User < ActiveRecord::Base
  has_one :cart, dependent: :destroy
  belongs_to :brand
  belongs_to :user_detail, dependent: :destroy
  has_many :user_wishes
  has_many :products, :through => :user_wishes
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  attr_accessor :login
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:login]
  validates :username, presence: true, uniqueness: true
    def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      elsif conditions.has_key?(:username) || conditions.has_key?(:email)
        where(conditions.to_hash).first
      end
    end
    mount_uploader :picture, PictureUploader
end
