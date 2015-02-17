class User < ActiveRecord::Base
  validates_presence_of :email
  validates_uniqueness_of :email, :username
  validates :password,length: { minimum: 6 }, :allow_blank => true
  validates :admin_obj_id, :presence => true, :if => :admin_level_present?
  before_save :create_username
  has_many :admin_roles, dependent: :destroy
  has_many :forums, :class_name => "Forum", :foreign_key => 'created_by' 
  # belongs_to :user, class_name: 'User', foreign_key: :banned_by

  has_attached_file :image, :styles => { :small => "100x100", :large => "500x500>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates_attachment_size :image, :in => 0.megabytes..5.megabytes
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  attr_accessor :admin_level, :admin_obj_id
  # crop_attached_file :image

  has_secure_password

  def create_username
  	self.username = Faker::Internet.user_name unless self.username
  end

  def admin_level_present?
    return true if self.admin_level && self.admin_level == "Forum"
    return false
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

  def forum_admin_ids
    ['']
  end

  def highest_admin_level
    return admin_types_array.first
  end

  def banned_by
  	User.find_by_id(super)
  end

  def admin_of?(obj)
    return true if super_admin?
    return false if obj.id == nil
    roles = AdminRole.where(admin_id: obj.id).where(admin_type: obj.class.to_s.downcase)
    return true if roles.count > 0
    return false
  end

  def admin_types
    return self.admin_roles.map{ |m| [m.admin_type.capitalize,m.admin_id].reject!(&:blank?).join(':')}.join(',')
  end

  def admin_types_array
    return self.admin_roles.map{ |m| [m.admin_type.capitalize,m.admin_id].reject!(&:blank?).join(':')}
  end

  def higher_than?(other)
    return true if self.king?
    return true if !other.king?  && !other.queen? && self.queen?
    return true if !other.queen? && self.admin_types.lenght > 0
    return false
  end

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
    
  def reprocess_avatar
    image.reprocess!
  end
  
  def avatar_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(image.path(style))
  end

  def destroy_original
    File.unlink(self.image.path)
  end

  def cart
    return @cart if @cart
    cart = Cart.where(user_id: self.id)
    if cart.count > 0
      cart = cart.where(donation_id: nil)
      if cart.count > 0
        return @cart = cart.first
      end
    end
    return @cart = Cart.create(user_id: self.id)
  end

end
