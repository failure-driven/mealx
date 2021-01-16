class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def user_actions=(value)
    self[:user_actions] = value.is_a?(String) ? JSON.parse(value) : value
  end
end