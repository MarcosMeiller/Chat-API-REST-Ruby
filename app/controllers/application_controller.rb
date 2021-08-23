class ApplicationController < ActionController::API

  def current_user
    user_id = request.headers['User-Id']
    @user ||= User.find_by(id: user_id)
  end

end
