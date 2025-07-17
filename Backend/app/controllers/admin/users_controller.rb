class Admin::UsersController < ApplicationController
  skip_before_action :check_login
  def index
    @users = params[:search].present? ? User.search(params[:search]) : User.none
    render json: @users, each_serializer: UserSerializer
  end
end
