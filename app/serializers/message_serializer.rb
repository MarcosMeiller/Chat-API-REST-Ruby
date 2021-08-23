class MessageSerializer < ActiveModel::Serializer
  attributes :id, :content, :polarity, :created_at, :is_edited, :is_censored
end
