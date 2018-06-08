json.extract! article, :title, :slug, :body, :description, :created_at, :updated_at
json.author article.user, partial: 'users/profile', as: :user
json.favorited user_signed_in? ? current_user.favorited?(article) : false
json.favorites_count article.favorites_count || 0
