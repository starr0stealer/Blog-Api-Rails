json.ignore_nil!

json.user do
  json.set! :id, current_user.id
  json.set! :email, current_user.email
  json.partial! 'users/user', user: current_user
end

json.token request.env['warden-jwt_auth.token']
