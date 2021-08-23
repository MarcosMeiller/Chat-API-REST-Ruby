class Message < ApplicationRecord
  include Censor

  belongs_to :chat
  belongs_to :user
  validates :content, presence: true
  before_save :control_polarity
  before_save :control_words
  validate :update_last, on: :update

  def update_last
    message_id = chat.messages.where(user_id: user.id).last.id
    errors.add(:message, 'Only can edit last message') unless message_id == id
  end

  def control_polarity
    self.polarity = MessageService.call(content)
  end

  def control_words
    original_content = String.new(content)
    BAD_WORDS.each { |word| content.gsub! word, '***' if content.include? word }

    self.is_censored = true if content != original_content
  end

end
