json.partial! 'users/user', user: user
json.following user_signed_in? ? current_user.following?(user) : false
