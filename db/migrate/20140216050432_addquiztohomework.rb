class Addquiztohomework < ActiveRecord::Migration
  def change
    add_column :homeworks, :quiz, :boolean, :default => false
  end
end
