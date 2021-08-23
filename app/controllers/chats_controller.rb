class ChatsController < ApplicationController
  before_action :current_user, only: [:create , :index]

  def create
    if receptor_user.nil? || current_user.nil?
      return render json: { message: "user doesn't exists" },
                    status: :not_found
    end
    chat = Chat.new
    if chat.save
       chat.users << [@receptor_user, @user]
       render json: chat, serializer: ChatCreateSerializer,
              status: :created
    else
      render json: { message: " Couldn't Start the Chat", errors: chat.errors },
             status: :bad_request
    end
  end

  def index
    return render json: { message: "user doesn't exists" }, status: :not_found if current_user.nil?

    render json: current_user.chats, status: :ok
  end

  private

  def receptor_user
    @receptor_user ||= User.find_by(id: params['id'])
  end
end
