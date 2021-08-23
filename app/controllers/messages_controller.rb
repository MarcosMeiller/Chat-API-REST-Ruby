class MessagesController < ApplicationController
  before_action :current_user, only: [:create, :update, :show, :index]

  def create
    return render json: { message: "chat doesn't exists" }, status: :not_found if chat.nil?
    return render json: { message: "user doesn't exists" }, status: :not_found if current_user.nil?

    message = @chat.messages.build(message_params)
    @user.messages << message
    if message.save
      render json: message, status: :created
    else
      render json: { message: " Couldn't be created ", errors: message.errors },
             status: :bad_request
    end
  end

  def index
    return render json: { message: "chat doesn't exists" }, status: :not_found if chat.nil?

    render json: @chat.messages, status: :ok, each_serializer: MessagesSerializer, user_settings: @user.settings
  end

  def show
    return render json: {message: 'chat not found'}, status: :not_found if chat.nil?

    message = chat.messages.find_by(id: params[:id])
    if message
      render json: message, status: :ok
    else
      render json: { message: 'message not found' }, status: :not_found
    end
  end

  def update 
    if chat.nil? || message.nil? || current_user.nil?
      return render json: { message: "user, chat or message doesn't exists" },
                    status: :not_found
    end
    if update_unauthorized_user
      return render json: { message: "you cannot modify a message that does not belong to the user" },
                    status: :unauthorized
    end

    if validate_chat
      return render json: { message: "you cannot modify a message that does not belong to the chat" },
                    status: :bad_request
    end

    @message.is_edited = true
    if @message.update(message_params)
      render json: @message, status: :ok
    else
      render json: @message.errors, status: :bad_request
    end
  end

  private

  def update_unauthorized_user
    @user != @message.user
  end

  def validate_chat
    @chat.id != @message.chat_id
  end

  def message_params
    params.require(:message).permit(:content)
  end

  def chat
    @chat ||= Chat.find_by(id: params[:chat_id])
  end

  def message
    @message ||= Message.find_by(id: params['id'])
  end
end
