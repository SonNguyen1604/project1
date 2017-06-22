class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :micropost

  validates :content, :user_id, :micropost_id, presence: true
end
