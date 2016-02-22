class User < ActiveRecord::Base
	has_secure_password

	has_many :articles
  has_many :authentications

	validates :email, format: { with: /@/, message: "Email needs an @"}, uniqueness: true
    validates :name, presence: true
    before_create { generate_token(:auth_token) }

    attr_accessor :old_password
  
  def update_with_password(params)
    unless params[:password].blank?
      if self.authenticate params[:old_password]
        self.assign_attributes(params)
      else
        self.errors.add(:old_password, "is incorrect.")
        self.assign_attributes(params)
        return false
      end
    else
      self.assign_attributes(params)
    end
    self.save
  end
  
  def send_reset_token
    generate_token(:password_reset_token)
    self.password_reset_time = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

    def generate_token(column)
	    begin
	      self[column] = SecureRandom.urlsafe_base64
	    end while User.exists?(column => self[column])
  	end
  def apply_hash(user_hash)
    if user_hash['info']
      self.name = user_hash['info']['name']
      self.email = user_hash['info']['email']
      self.password_digest = '0'
    end
  end
end
