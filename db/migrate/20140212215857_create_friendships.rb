class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :tutor_id
      t.integer :student_id
      t.boolean :pending
      t.boolean :approved

      t.timestamps
    end
  end
end
