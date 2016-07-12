class Song < ActiveRecord::Base

  belongs_to :user
  
  validates :title, presence: true
  validates :author, presence: true
  
end