class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist

  has_many :articles,  dependent: :destroy
  has_many :comments,  dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :username, uniqueness: { case_sensitive: false },
                       format: { with: /\A[a-zA-Z0-9]+\z/ },
                       presence: true,
                       allow_blank: false

  def favorite(article)
    favorites.find_or_create_by(article: article)
  end

  def unfavorite(article)
    favorites.where(article: article).destroy_all

    article.reload
  end

  def favorited?(article)
    favorites.find_by(article_id: article.id).present?
  end
end
