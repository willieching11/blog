class ArticlesController < ApplicationController
  before_action :authorize
  before_action :set_article, only: [:show, :edit, :update, :destroy ]

    def index
      @articles = Article.all
    end

	  def new
      @article = Article.new
  	end

	  def create
      @article = Article.new(article_params)
      respond_to do |format|
        if @article.save
          format.html {redirect_to @article, notice: "Successfully created Article."}
          format.js 
        else
          format.html {render :new}
        end
      end
    end

    def show
    end

    def edit
    end
  
    def update
      if @article.update_attributes(article_params)
        redirect_to @article, notice: "Successfully saved Article."
      else
        render :edit
      end
    end
  
    def destroy
      @article.destroy
      respond_to do |format|
        format.html {redirect_to articles_path, notice: "Deleted Article."}
        format.js
      end
    end

    def set_article
      @article = Article.find(params[:id])
    end

    private
  
    def article_params
      params.require(:article).permit(:title,:post)
    end

    
end
