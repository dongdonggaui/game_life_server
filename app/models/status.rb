class Status < ActiveRecord::Base
  belongs_to :user
  include Grape::Entity::DSL
  class Entity < Grape::Entity
    expose :id, :title, :content, :created_at
    expose :user, using: User::UserInfo::Entity
  end
end
