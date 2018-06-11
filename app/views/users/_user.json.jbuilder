json.extract! user, :username, :bio
json.set! :image, "#{request.base_url}/users/#{user.username}/image"
