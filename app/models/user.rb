class User < ApplicationRecord
  validates :email, {uniqueness: true, presence: true, length:{maximum:100}}
  validates :name,  {uniqueness: true, presence: true, length:{maximum:100}}
  validates :password, {presence: true}


  def posts
    return Post.where(user_id: self.id)
  end
  
end
