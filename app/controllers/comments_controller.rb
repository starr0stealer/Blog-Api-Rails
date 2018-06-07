class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :find_article!
  before_action :find_comment!,      only: [:destroy]

  def index
    @comments = @article.comments.order(created_at: :asc)
  end

  def create
    @comment = @article.comments.new(comment_params)
    @comment.user = current_user

    render json: { errors: @comment.errors }, status: :unprocessable_entity unless @comment.save
  end

  def destroy
    if @comment.user_id == current_user.id
      @comment.destroy
      head :no_content
    else
      render json: { errors: { comment: ['not owned by user'] } }, status: :forbidden
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_article!
    @article = Article.find_by!(slug: params[:article_slug])
  end

  def find_comment!
    @comment = @article.comments.find(params[:id])
  end
end
