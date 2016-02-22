class CommentsController < ApplicationController
  before_action :set_article
  before_action :set_comment, only: [:edit, :update, :show, :destroy]

  def create
    @comment = @article.comments.create(comment_params)
    if @article.comments << @comment
      redirect_to @article, notice: "Created Comment"
    else
      render :new
    end
  end

  def new
    @article = Article.find(params[:article_id])
  end

  def edit 
  end
  
  def show
  end
  
  def update
    if @comment.update_attributes(comment_params)
      redirect_to [@article,@comment], notice: "Comment Updated."
    else
      render :edit
    end
  end
  
  def destroy 
    @comment.destroy
    redirect_to @article
  end
  
  private

  def set_article
      @article = Article.find(params[:article_id])
  end
  
  def set_comment
    @comment = @article.comments.find(params[:id])
  end
  
  def comment_params
    params.require(:comment).permit(:commenter,:context)
  end
end
