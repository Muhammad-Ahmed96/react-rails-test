class ApplicationController < ActionController::API
  include TimeFormatter
  attr_reader :current_user

  before_action :check_login

  def check_admin?
    unless current_user.admin?
      render json: { error: "You are not allowed to access this section" }, status: :unauthorized
    end
  end

  private

  def check_login
    payload = JsonWebToken.decode(auth_token)
    if payload[:error]
      render json: { error: payload[:error] }, status: :unauthorized
    else
      @current_user = User.find_by(id: payload["sub"])
      unless @current_user
        render json: { error: "Unauthorized" }, status: :unauthorized
      end
    end
  end

  def auth_token
    @auth_token ||= request.headers["Authorization"]&.split(" ")&.last
  end
end
