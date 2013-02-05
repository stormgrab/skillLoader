class Post < ActiveRecord::Base
  attr_accessible :comments_count, :content, :title, :vote
	
	has_many :comments, dependent: :destroy
	belongs_to :user
	
	validate :title,:content, presence: true
	
	accepts_nested_attributes_for :comments
end
