class User < ApplicationRecord
  # Devise-Module, falls vorhanden
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
end
