class Chat < ApplicationRecord
    has_many :users_chats
    has_many :users, through: :users_chats
    has_many :messages
end
