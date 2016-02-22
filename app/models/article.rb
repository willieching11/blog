class Article < ActiveRecord::Base
	has_many :comments
	belongs_to :user

	validates :title, presence: true,
		length: {maximum: 50}
  	validates :post, presence: true
end
