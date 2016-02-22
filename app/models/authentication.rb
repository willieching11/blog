class Authentication < ActiveRecord::Base
	belongs_to :user
  
  validates :uid, presence: true
  validates :provider, presence: true
  
  def self.find_or_create_with_hash(omniauth)
    uid = omniauth['uid']
    provider = omniauth['provider']
    authentication = Authentication.where(uid: uid, provider: provider).first
    if authentication
      authentication
    else
      Authentication.create!(uid: uid, provider: provider)
    end
  end
end
