class Comment < ActiveRecord::Base
	belongs_to :post

	validates :email, :content, :post_id, presence: true
end
