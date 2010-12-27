# == Schema Information
#
# Table name: comments
#
#  id               :integer(4)      not null, primary key
#  body             :text
#  author_id        :integer(4)
#  created_at       :datetime
#  updated_at       :datetime
#  commentable_id   :integer(4)
#  commentable_type :string(255)
#

class Comment < ActiveRecord::Base
  belongs_to :author, :class_name => "User"
  belongs_to :commentable, :polymorphic => true
  
  validates :body, :presence => true
  validates :author, :presence => true
end
