json.extract! article, :title, :slug, :body, :description, :created_at, :updated_at
json.author article.user, partial: 'users/user', as: :user
