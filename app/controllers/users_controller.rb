class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { message: " Couldn't be registered ", errors: @user.errors },
             status: :bad_request
    end
  end

  def index
    return render json: { message: "user doesn't exists" }, status: :not_found if user.nil?

    users ||= User.where.not(id: user.id)
    render json: users, each_serializer: UsersSerializer, status: :ok
  end

  def show
    return render json: { message: "user doesn't exists" }, status: :not_found if user.nil?

    render json: @user, status: :ok
  end

  def update
    if user.update(user_params)
      render json: @user, status: :ok
    else
      render json: { message: " Couldn't be updated ", errors: @user.errors },
             status: :bad_request
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :settings)
  end

  def user
    user_id = if request.headers['User-Id'].nil?
                params['id']
              else
                request.headers['User-Id']
              end
    @user ||= User.find_by(id: user_id)
  end
end
