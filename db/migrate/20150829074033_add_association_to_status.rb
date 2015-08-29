class AddAssociationToStatus < ActiveRecord::Migration
  def change
    add_belongs_to :statuses, :user, index: true
  end
end
