class Relationship < ApplicationRecord
 has_many :followings, through: :active_relationships, source: :followed
  
    belongs_to :follower, class_name: "User"
    belongs_to :followed, class_name: "User"
end
  
