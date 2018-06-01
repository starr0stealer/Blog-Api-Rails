class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:current, :update]
  before_action :find_user!,         only: [:show]

  def current; end

  def show; end

  def update
    if current_user.update(user_params)
      render :current
    else
      render json: { errors: current_user.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :bio, :image)
  end

  def find_user!
    @user = User.find_by!(username: params[:username])
  end
end
