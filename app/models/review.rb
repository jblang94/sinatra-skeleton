class Review < ActiveRecord::Base

  validates :review, presence: true
  
end