class User < ActiveRecord::Base
  validates :email, presence: true
  validates_uniqueness_of :email, :username
  validates :password,length: { minimum: 6 }, :allow_blank => true
  before_save :create_username
  has_many :admin_roles
  # belongs_to :user, class_name: 'User', foreign_key: :banned_by

  has_secure_password

  def create_username
  	self.username = Faker::Internet.user_name unless self.username
  end

  def admin?
  	return true if self.admin_roles.count > 0
  	return false
  end

  def super_admin?
  	return true if king? || queen?
  	return false
  end

  def king?
  	return true if self.admin_roles.map{|m| m.admin_type.downcase}.include?('king')
  	return false
  end

  def queen?
  	return true if self.admin_roles.map{|m| m.admin_type.downcase}.include?('queen')
  	return false
  end

  def banned_by
  	User.find_by_id(super)
  end

end
