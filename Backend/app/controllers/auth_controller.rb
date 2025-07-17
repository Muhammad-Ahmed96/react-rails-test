class AuthController < ApplicationController
  skip_before_action :check_login, only: [ :create ]

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      render json: { user: UserSerializer.new(user), token: ::JsonWebToken.encode({ sub: user.id }) }, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end
end
