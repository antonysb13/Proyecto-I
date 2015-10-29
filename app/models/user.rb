class User < ActiveRecord::Base
  has_many :comments
  has_many :likes
  has_many :products
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  # omniauthable was added, now Devise can recognize OmniAtuh
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable, :omniauth_providers => [:facebook]

  #validates_presence_of :name, :email, :password, :password_confirmation
  before_save :assign_role

  def admin?
    if self.role == "Admin"
      true
    else
      false
    end
  end

  def regular?
    if self.role == "Regular"
      true
    else
      false
    end
  end

  def guest?
    if self.role == "Guest"
      true
    else
      false
    end
  end

  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.phone = auth.info.phone
        user.name = auth.info.name
        user.password = Devise.friendly_token[0,20]
        user.save!
      end

  #Rescue function to manage the exception when an user tries to sign up with an email already registered.
  rescue ActiveRecord::StatementInvalid => error
    
  end
  
  def already_likes?(product)
    self.likes.find(:all, :conditions => ['product_id = ?', product.id]).size > 0
  end

  def size_likes?(product)
    self.likes.find(:all, :conditions => ['product_id = ?', product.id]).size
  end

  def email_required?
    (authentications.empty? || !email.blank?) && super
  end

  def assign_role
    if self.email.nil? and self.name.nil?
      self.role = "Guest" if self.role.nil?
    else
      self.role = "Regular" if self.role.nil?
    end
  end

end
