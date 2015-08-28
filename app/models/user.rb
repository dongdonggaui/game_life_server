class User < ActiveRecord::Base
  validates_uniqueness_of :username
  has_secure_password
end

class UserInfo < User
  include Grape::Entity::DSL
  class Entity < Grape::Entity
    expose :id, :nickname, :email, :gender, :description, :avatar_url
  end
end
