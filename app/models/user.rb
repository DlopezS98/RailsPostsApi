class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def commit_user
    self.normalized_email = email.strip.upcase
    self.normalized_username = username.strip.upcase
    self.save()
  end
end
