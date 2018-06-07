class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :find_article!,      except: [:create]

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
