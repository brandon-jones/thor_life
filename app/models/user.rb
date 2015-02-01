class User < ActiveRecord::Base
  validates :email, presence: true
  validates_uniqueness_of :email, :username
  validates :password,length: { minimum: 6 }
  before_save :create_username

  has_secure_password

  def create_username
  	self.username = Faker::Internet.user_name
  end
end
