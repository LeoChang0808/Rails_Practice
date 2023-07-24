class ArticlesController < ApplicationController

    before_action :set_article, only: [ :show ]
    before_action :authenticate_user!, except: [ :index, :show ]
    before_action :set_user_article, only: [ :edit, :update, :destroy ]
    # before_action :set_article, except: [ :index, :new, :create ]


    def index
        @articles = Article.order(id: :desc)
    end
  
    def show
    end

    def new
        # @實體變數
        @article = Article.new
    end

    def create
        # @article = Article.new(article_params) 
        @article = current_user.articles.new(article_params) 

        if @article.save
            redirect_to "/articles", notice:"文章新增成功囉 ! "
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @article.update(article_params)
            redirect_to articles_path, notice:"文章更新成功囉 ! "
        else
            render :edit
        end
    end

    def destroy
        @article.destroy
        redirect_to articles_path, notice:"文章刪除成功囉 ! "
    end

    private
    def article_params
        params.require(:article).permit(:title, :context, :sub_title)
                                # .merge(user: current_user)
    end

    def set_article
        @article = Article.find(params[:id])
    end

    def set_user_article
        @article = current_user.articles.find(params[:id])
    end
end
