class User < ActiveRecord::Base
  validates_uniqueness_of :username
  has_secure_password
  has_many :statuses, dependent: :destroy
  # include Grape::Entity::DSL
  # def entity
  #   Entity.new(self)
  # end
  # class Entity < Grape::Entity
  #   expose :id, :nickname, :email, :gender, :description, :avatar_url
  # end
end

class UserInfo < User
  include Grape::Entity::DSL
  class Entity < Grape::Entity
    expose :id, :nickname, :email, :gender, :description
    expose :avatar_url, documentation: { type: 'String', desc: 'Status update text.' }
  end
end
