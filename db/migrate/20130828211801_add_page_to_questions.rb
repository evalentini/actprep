class AddPageToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :page, :integer
  end
end
