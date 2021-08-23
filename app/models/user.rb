class User < ApplicationRecord
  has_many :users_chats
  has_many :chats, through: :users_chats
  has_many :messages

  enum settings: { default: 'default',
                   upercase: 'upercase',
                   lowercase: 'lowercase',
                   no_accent: 'no_accent' }
  has_secure_password

  validates :first_name, :last_name, :password, presence: true
  validates :email, uniqueness: true, presence: true, format: { with: /[^@\s]+@[^@\s]+\z/ }
end
