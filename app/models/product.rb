class Product < ActiveRecord::Base
  has_attached_file :avatar, styles: { medium: "200x200>", thumb: "100x100>" }, default_url: "missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  
  has_many :comments
  has_many :likes
  has_many :images
  has_many :categories

  belongs_to :user

  def self.search(search)
  	if search
  		where(['name LIKE ?', "%#{search}%"])
  	else
  		all
  	end
  end
end
