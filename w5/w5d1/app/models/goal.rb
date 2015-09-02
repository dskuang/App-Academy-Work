class Goal < ActiveRecord::Base
  belongs_to :user
  has_many :comments, as: :commentable
  validates :title, :user_id, :body, presence: true
end
