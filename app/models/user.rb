class User < ActiveRecord::Base
  has_secure_password

  has_many :reviews, dependent: :destroy

  validates :name, presence: true
  validates :username, presence:true,format: /\A[A-Z0-9]+\z/i, 
  					 uniqueness:{case_sensitive: false}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i   

  validates :email, presence: true,format:{with:VALID_EMAIL_REGEX},
					uniqueness:{case_sensitive:false}

  validates :password, length: { minimum: 6, allow_blank: true }


  # Idea is to just link to existing User on gravatar
  # Alternate way is to use paperclip gem to allow the user
  # push their images onto your app
  def gravatar_id
	  Digest::MD5::hexdigest(email.downcase)
  end
end
