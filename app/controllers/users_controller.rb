require 'net/http'

class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:current, :update]
  before_action :find_user!,         only: [:show, :image]

  def current; end

  def show; end

  def update
    if current_user.update(user_params)
      render :current
    else
      render json: { errors: current_user.errors }, status: :unprocessable_entity
    end
  end

  def image
    p request.base_url
    if @user.image.nil?
      return send_file Rails.root.join('public', 'avatar.png'),
                       type: 'image/png',
                       disposition: 'inline'
    end

    if @user.image =~ /^data:(.*?);(.*?),(.*)$/
      image_data = Base64.decode64(Regexp.last_match(3))
      image_type = Regexp.last_match(1)
    end

    if /\A#{URI.regexp(['http', 'https'])}\z/.match?(@user.image)
      url = URI.parse(@user.image)
      image = Net::HTTP.get_response(url)
      image_data = image.body
      image_type = image.content_type
    end

    send_data image_data,
              type: image_type,
              disposition: 'inline'
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :bio, :image)
  end

  def find_user!
    @user = User.find_by!(username: params[:username])
  end
end
