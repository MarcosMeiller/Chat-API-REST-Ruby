class ChatCreateSerializer < ActiveModel::Serializer
  attributes :id , :message

  def message()
    "chat created with #{object.users.first.first_name} #{object.users.first.last_name} at #{object.created_at}"
  end

  has_many :users, serializer: UsersSerializer
end
