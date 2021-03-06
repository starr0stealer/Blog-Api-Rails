class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_article!,      except: [:feed, :index, :create]

  def feed
    @articles = Article.includes(:user).where(user: current_user.follows.select(:followable_id))

    @articles_count = @articles.count

    @articles = @articles.order(created_at: :desc).offset(params[:offset] || 0).limit(params[:limit] || 20)

    render :index
  end

  def index
    @articles = Article.all.includes(:user)

    @articles = @articles.authored_by(params[:author]) if params[:author].present?
    @articles = @articles.favorited_by(params[:favorited]) if params[:favorited].present?

    @articles_count = @articles.count

    @articles = @articles.order(created_at: :desc).offset(params[:offset] || 0).limit(params[:limit] || 20)
  end

  def show; end

  def create
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.save
      render :show
    else
      render json: { errors: @article.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @article.user_id == current_user.id
      @article.update(article_params)

      render :show
    else
      render json: { errors: { article: ['not owned by user'] } }, status: :forbidden
    end
  end

  def destroy
    if @article.user_id == current_user.id
      @article.destroy

      head :no_content
    else
      render json: { errors: { article: ['not owned by user'] } }, status: :forbidden
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :description)
  end

  def find_article!
    @article = Article.find_by!(slug: params[:slug])
  end
end
