class Comment < ActiveRecord::Base
	belongs_to :article
  
    validates :commenter, presence: true
    validates :article_id, presence: true
end
