class User < ActiveRecord::Base


  include BCrypt

  has_many :songs
  has_many :upvotes
  
  validates :email, presence: true, uniqueness: true
  validates :password_hash, presence: true

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    if new_password.nil? || new_password.empty?
      self.password_hash = nil
    else
      @password = Password.create(new_password)
      self.password_hash = @password
    end
  end

end