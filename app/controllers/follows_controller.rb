class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user!

  def create
    current_user.follow(@user) if current_user.id != @user.id

    render 'users/show'
  end

  def destroy
    current_user.unfollow(@user) if current_user.id != @user.id

    head :no_content
  end

  private

  def find_user!
    @user = User.find_by!(username: params[:user_username])
  end
end
