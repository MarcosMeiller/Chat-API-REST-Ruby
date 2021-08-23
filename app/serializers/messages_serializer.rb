class MessagesSerializer < ActiveModel::Serializer
  include ActiveSupport::Inflector

  attributes :id, :content, :created_at, :is_edited, :is_censored

  def content
    message = object.content
    options = @instance_options[:user_settings]
    aplicate_settings(message, options)
  end

  private

  def aplicate_settings(message, options)
    case options
    when 'default'
      message
    when 'lowercase'
      message.downcase
    when 'upercase'
      message.upcase
    when 'no_accent'
      transliterate(message)
    end
  end
end
