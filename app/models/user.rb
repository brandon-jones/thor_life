class User < ActiveRecord::Base
  validates :email, presence: true
  validates_uniqueness_of :email, :username
end
