class Comment
  include Mongoid::Document
  field :content, :type => String

  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  has_many :comments, :as => :commentable
end
