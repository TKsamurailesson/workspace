class User < ApplicationRecord
  validates :email, {uniqueness: true, presence: true, length:{maximum:100}}
  validates :name,  {uniqueness: true, presence: true, length:{maximum:100}}

end
