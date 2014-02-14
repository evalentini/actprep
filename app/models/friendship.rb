class Friendship < ActiveRecord::Base
  attr_accessible :approved, :pending, :student_id, :tutor_id
  validates_uniqueness_of :tutor_id, :scope => :student_id
end
