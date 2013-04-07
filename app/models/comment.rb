class Comment < ActiveRecord::Base
  attr_accessible :content

	belongs_to :post
	belongs_to :user

	accepts_nested_attributes_for :post,allow_destroy: true

	after_save :updatePost

	def updatePost
		post=Post.find(self.post_id)
		post.noOfComments=post.comments.count
		post.save
	end
end
