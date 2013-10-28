class AddExplanationImageToQuestions < ActiveRecord::Migration
  def self.up
    add_attachment :questions, :explanation_image
  end
  def self.down 
    remove_attachment :questions, :explanation_image
  end
end
